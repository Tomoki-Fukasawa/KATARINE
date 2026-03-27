class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit]
  before_action :set_item, only: [:destroy, :show, :edit, :update]
  before_action :move_to_index, only: [:edit, :destroy]

  def index
    @items = Item.where(reservation: :available).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def show
    # @item_requests = ItemRequest.where(item: @item).where.not(transfer: ItemRequest.transfers[:completed]).order('created_at DESC')
    # @item_requests = ItemRequest.where(item: @item).order('created_at DESC')
    @item_requests = @item.item_requests.includes(:sender).order('created_at DESC')
  end

  def edit
  end

  def update
    if @item.user_id != current_user.id
      redirect_to root_path
      return
    end
    if @item.update(item_params)
      redirect_to @item
    else
      render :edit,status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :item_script, :category_id, :item_state_id,:prefecture_id, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    return if (current_user.id == @item.user_id) && @item.item_requests.empty?

    redirect_to action: :index
  end
end

