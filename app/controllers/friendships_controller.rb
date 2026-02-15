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
    
    # Friendship.create(user.id)
    # Friendship.create(friend.id)

    ActiveRecord::Base.transaction do
      friendship.update!(state: :accepted)

      Friend_ship.find_or_create_by!(
        user_id: friendship.friend_id,
        friend_id: friendship.user_id
      ) do |f|
        f.state = :accepted
      end
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    friendship = current_user.inverse_friendships.find(params[:id])

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
  
end
