class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    friend = User.find(params[:friend_id])
    # inverse_friendship = Friendship.find_by(user_id:friend, friend_id:current_user ,state: :pending)

    if Friendship.exists?(user_id:friend, friend_id:current_user ,state: :pending)
      puts "このユーザーはあなたと友達になりたがっています"
      return
    else
      current_user.friendships.create!(
        friend: friend,
        state: :pending
      )
    end
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

      ChatRoom.find_or_create_by!(
        user1_id: [friendship.user_id, friendship.friend_id].min,
        user2_id: [friendship.user_id, friendship.friend_id].max
      )
    end
    # @chat_room=chat_room.create(user1_id: user1, user2_id: user2)
    
    redirect_back(fallback_location: root_path)
  end

  def reject
    friendship = current_user.inverse_friendships.find(params[:id])
    friendship.update(state: :rejected)
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
  
end
