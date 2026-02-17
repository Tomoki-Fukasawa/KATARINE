class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    # accepted_ids = current_user.friendships.accepted.pluck(:friend_id)
    accepted_ids = current_user.friends.pluck(:friend_id)
    current_pending_ids = current_user.friendships.pending.pluck(:friend_id)
    inverse_pending_ids = current_user.inverse_friendships.pending.pluck(:user_id)

    exclude_ids = (accepted_ids + current_pending_ids +inverse_pending_ids).uniq

    @users = User.where(friend_want: true).where.not(id: current_user.id).where.not(id: exclude_ids)
    @boards = Board.all
  end
  
  def show
    @user=User.find(params[:id])
    @friendship = current_user.friendships.find_by(friend_id: @user.id) || current_user.inverse_friendships.find_by(user_id: @user.id) 
  end

  def friends
    @user = User.find(params[:id])
    @friends = @user.friends
    if @user == current_user
      @pending_sent = current_user.friendships.pending
      @pending_received = current_user.inverse_friendships.pending  
    end    
  end

  def friend_want
    @user = User.find(params[:id])
    current_user.update(friend_want: !current_user.friend_want)
    redirect_to user_path(@user)
  end
end
