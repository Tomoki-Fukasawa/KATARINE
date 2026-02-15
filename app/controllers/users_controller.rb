class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    accepted_ids = current_user.friendships.accepted.pluck(:friend_id)
    current_pending_ids = current_user.friendships.pending.pluck(:friend_id)
    inverse_pending_ids = current_user.inverse_friendships.pending.pluck(:friend_id)

    exclude_ids = (accepted_ids + current_pending_ids +inverse_pending_ids).uniq

    @users = User.where(friend_want: true).where.not(id: current_user.id).where.not(id: exclude_ids)
    # @friends =Friend.where(id: friend.id).where.not(current_user.friendship.accepted)
    @boards = Board.all
  end
  
  def show
    @user=User.find(params[:id])
  end

  def friends
    @user = User.find(params[:id])
    # @friends = @user.friends + @user.inverse_friends
    # @friends = @user.friendships.accepted.includes(:friend).map(&:friend)
    @friends = @user.friends
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

    current_user.update(friend_want: !current_user.friend_want)

    # @user.update(friend_want: !@user.friend_want)
    # current_user.update_column(:friend_want, !@user.friend_want)
    # Rails.logger.debug @user.errors.full_messages
    redirect_to user_path(@user)
  end

end
