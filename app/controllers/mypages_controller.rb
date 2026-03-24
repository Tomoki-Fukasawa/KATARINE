class MypagesController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @item_requests=current_user.sent_requests.includes(:item)
    @items=current_user.items.includes(:user)
  end
end
