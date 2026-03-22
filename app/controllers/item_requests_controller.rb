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
      redirect_to item_path(@item)
    else
      render_to :new
    end
  end

  def accept
    begin
      @item_request.request_accepted!(@item.user)
      redirect_to item_path(@item_request.item), notice: "承認しました"
    rescue ActiveRecord::RecordNotUnique
      redirect_to item_path(@item_request.item), alert: "他のユーザーが先に承認しました"
    end
  end

  def complete
    if @item_request.request_completed!(@item_request.sender)
      redirect_to item_path(@item_request.item), notice: "完了しました"
    else
      redirect_to item_path(@item_request.item)
    end
  end

  def destroy
    if @item_request.accepted?
      return redirect_to root_path unless current_user==@item_request.item.user
      @item_request.request_accepted_cancel(current_user)
    else
      return redirect_to root_path unless current_user==@item_request.sender
      @item_request.destroy!
    end
    redirect_to item_path(@item_request.item)
  end


  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def sent_item_request
    @item_request=ItemRequest.find(params[:id])
  end

  def authorize_accept!
    return if current_user == @item_request.item.user

    redirect_to root_path, alert: "権限がありません"
  end

  def authorize_complete!
    return if current_user == @item_request.sender

    redirect_to root_path, alert: "権限がありません"
  end
end
