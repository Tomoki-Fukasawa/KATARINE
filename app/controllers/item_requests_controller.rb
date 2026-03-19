class ItemsRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:new,:create]
  before_action :sent_item_request,only:[:accept,:complete,:destroy]
  before_action :authorize_accept!,only:[:accept]
  before_action :authorize_complete!,only:[:complete]

  def index
    @item_requests = ItemRequest.where.not(transfer: ItemRequest.transfers[:completed]).order('created_at DESC')
  end

  def new
    @item_request = ItemRequest.new
  end

  def create
    if @item.reserved? or @item.completed?
      return redirect_back(fallback_location: root_path)
    end
    @item_request=ItemRequest.new(
      item: @item,
      sender: current_user,
      transfer: :waiting
    )
    if @item_request.save
      redirect_back(fallback_location: root_path)
    else
      render_to :new
    end
  end

  def accept
    begin
      @item_request.request_accepted!
      redirect_to item_path(@item_request.item), notice: "承認しました"
    rescue ActiveRecord::RecordNotUnique
      redirect_to item_path(@item_request.item), alert: "他のユーザーが先に承認しました"
    end
  end

  def complete
    @item_request.request_completed!
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

  def authorize_complete!
    return if current_user == @item_request.item.user

    redirect_to root_path, alert: "権限がありません"
  end

  def authorize_complete!
    return if current_user == @item_request.sender

    redirect_to root_path, alert: "権限がありません"
  end
end
