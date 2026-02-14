class FriendshipsController < ApplicationController
  def create
    # @user
    # friendships=
    friend = User.find(params[:friend_id])
    
    current_user.friendships.create(
      friend: friend,
      state: :pending
    )

    redirect_back(fallback_location: root_path)
  end

  def update
    # friendship=Friendship.find(state: :pending)
    # friendship=Friendship.find(params[:id])
    friendship = current_user.inverse_friendships.find(params[:id])
    friendship.update(state: :accepted)
    # Friendship.create(user.id)
    # Friendship.create(friend.id)
    Friendship.create(
      user_id: friendship.friend_id,
      friend_id: friendship.user_id,
      state: :accepted
    )
    redirect_back(fallback_location: root_path)
  end
  
end
