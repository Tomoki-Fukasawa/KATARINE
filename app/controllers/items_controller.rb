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
    if Item.exists?(reservation: :available?)
      return 
    else
      @item = Item.new(item_params)
      if @item.save
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity
      end
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def show
  end

  def edit
  end

  def update
    unless @item.user_id == current_user.id
      redirect_back(fallback_location: root_path)
      return
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

