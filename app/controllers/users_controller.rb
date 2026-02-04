class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.where(friend_want: true).where.not(id: current_user.id)
    @boards = Board.all
  end
  
  def show
    @user=User.find(params[:id])
    @nickname=current_user.nickname
    @birth_day=current_user.birth_day
  end
  def friend_want
    current_user.update(friend_want: !current_user.friend_want)
    redirect_to user_path(current_user)
  end
end
