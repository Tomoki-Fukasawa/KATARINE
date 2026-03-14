class ItemsRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :move_to_root, only: [:index]

  

  def create
    @item=Item.find(params[:item_id])
    if current_user.item_request.exists?(item_id:@item.id)
      puts "この物品は既に作成されています。"
      redirect_back(fallback_location: root_path)
      return
    end
    current_user.item_request.create!(
      item: @item,
      receiver: @item.user,
      transfer: :pending
    )
    redirect_back(fallback_location: root_path)
  end

  def update
    item_request = @item.item_requests.find(params[:id])
      if @item.item_requests.where(transfer: :accepted).exists? or @item.item_requests.where(transfer: :completed).exists?
        return
      else
        ActiveRecord::Base.transaction do
          item_request.update!(item: @item,sender_id: item_request.user,receiver_id: @item.user,transfer: :accepted)
          @item.item_requests.where.not(id: item_request.id).update_all(transfer: :rejected)
        end
      end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    item_request=current_user.item_requests.find(params[:id])
    ActiveRecord::Base.transaction do
      item_request.destroy!
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_root
    return if (current_user.id != @item.user_id) && !item_requests.exists?

    redirect_to root_path
  end
end
