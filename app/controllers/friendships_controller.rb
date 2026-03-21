class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :friendship_set,only: [:update,:reject]
  def create
    friend = User.find(params[:friend_id])
    inverse_friendship = Friendship.find_by(user_id:friend, friend_id:current_user)
    friendship = Friendship.find_by(user_id:current_user, friend_id:friend)

    # status = current_user.friendship_status_with(friend)
    
    if current_user.friends_with?(friend)
      redirect_to user_path(friend), alert: "この友達関係はすでに承認されてます"
      return
    elsif current_user.pending_received_from?(friend)
      redirect_to user_path(friend), alert: "このユーザーはあなたと友達になりたがっています"
      return
    elsif current_user.pending_sent_to?(friend)
      redirect_to user_path(friend), alert: "この友達関係はすでに作成されてます"
      return 
    elsif current_user.friends_reject?(friend)
      redirect_to user_path(friend), alert: "この友達関係は一度拒否されてます"
      return
    else
      current_user.friendships.find_or_create_by(
        user: current_user,
        friend: friend
      )
      redirect_to friends_user_path(current_user), notice: "作成されました。"
      return
    end
  end

  def update
    @friendship.inverse_state!(:accepted)
    redirect_to friends_user_path(current_user)
  end

  def reject
    @friendship.inverse_state!(:rejected)
    redirect_to friends_user_path(current_user)
  end

  def destroy
    # friendship = current_user.inverse_friendships.find(params[:id])
    friendship = current_user.friendships.find(params[:id])
    ActiveRecord::Base.transaction do
      inverse = Friendship.find_by(
        user_id: friendship.friend_id,
        friend_id: friendship.user_id
      )
      friendship.destroy!
      inverse&.destroy!
    end
    redirect_back(fallback_location: root_path)
  end

  def friendship_set
    @friendship = current_user.inverse_friendships.find(params[:id])
  end
  
end
