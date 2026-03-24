class MypageController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @item_requests=current_user.sent_requests.includes(:item)
    @items=current_user.items.includes(:user)
  end
end
