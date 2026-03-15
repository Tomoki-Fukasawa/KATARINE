class ItemsRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:new,:create]
  # before_action :move_to_root, only: [:new,:create]
  before_action :sent_item_request,only:[:update,:destroy]

  def index
    @item_requests = ItemRequest.where.not(transfer: :completed).order('created_at DESC')
  end

  def new
    @item_request = ItemRequest.new
  end

  def create
    if @item.item_requests.exists?(sender: current_user) or @item.reserved? or @item.completed?
      redirect_back(fallback_location: root_path)
    end
    ItemRequest.create(
      item: @item,
      sender: current_user,
      transfer: :pending
    )
    if ItemRequest.save
      redirect_back(fallback_location: root_path)
    else
      render_to "new"
    end
  end

  def update
    if @item_request.completed?
      return
    elsif @item_request.accepted? 
      @item.update!(reservation: :completed)
    else
      ActiveRecord::Base.transaction do
        @item_request.update!(item: @item,sender_id: @item_request.user,transfer: :accepted)
        @item.item_requests.where.not(id: item_request.id).update_all(transfer: :rejected)
        @item.update!(reservation: :reserved)
      end
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @item_request.destroy!
    redirect_back(fallback_location: root_path)
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def sent_item_request
    @item_request=ItemRequest.find(params[:id])
  end

  # def move_to_root
  #   return if (current_user.id != @item_request.user_id)

  #   redirect_to root_path
  # end
end
