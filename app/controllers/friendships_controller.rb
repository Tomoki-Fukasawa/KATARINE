class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend_id])
    current_user.friendships.create!(
      friend: friend,
      state: :pending
    )
    redirect_back(fallback_location: root_path)
  end

  def update
    friendship = current_user.inverse_friendships.find(params[:id])
    # friendship = Friendship.find(params[:id])
    unless friendship.friend_id == current_user.id
      redirect_back(fallback_location: root_path)
      return
    end
    ActiveRecord::Base.transaction do
      friendship.update!(state: :accepted)

      Friendship.create!(
        user_id: friendship.friend_id,
        friend_id: friendship.user_id,
        state: :accepted
      )
      # ) do |f|
      #   f.state = :accepted
    end
    redirect_back(fallback_location: root_path)
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
  
end
