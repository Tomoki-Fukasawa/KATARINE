class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    accepted_ids = current_user.friendships.accepted.pluck(:friend_id)
    @users = User.where(friend_want: true).where.not(id: current_user.id).where.not(id: accepted_ids)
    # @friends =Friend.where(id: friend.id).where.not(current_user.friendship.accepted)
    @boards = Board.all
  end
  
  def show
    @user=User.find(params[:id])
  end

  def friends
    @user = User.find(params[:id])
    # @friends = @user.friends + @user.inverse_friends
    @friends = @user.friendships.accepted.includes(:friend).map(&:friend)
  end
  # def friend_want
  #   current_user.update(friend_want: !current_user.friend_want)
  #   redirect_to user_path(current_user)
  # end

  def friend_want
    @user = User.find(params[:id])

    # unless @user.update(friend_want: !@user.friend_want)
    #   Rails.logger.debug @user.errors.full_messages
    # end

    # @user.update(friend_want: !@user.friend_want)
    current_user.update_column(:friend_want, !@user.friend_want)
    # Rails.logger.debug @user.errors.full_messages
    redirect_to user_path(@user)
  end

end
