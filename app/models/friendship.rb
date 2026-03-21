class Friendship < ApplicationRecord
  after_update :create_chat_room,if: :should_create_chatroom?

  belongs_to :user
  belongs_to :friend,class_name: "User"
  # has_many :messages
  # has_one :chat_room, dependent: :destroy

  enum state: { pending: 0, accepted: 1, rejected: 2 }

  validates :user_id,uniqueness: {scope: :friend_id }

  def create_chat_room
    user1_id,user2_id =[user_id, friend_id].sort

    ChatRoom.find_or_create_by(
      user1_id: user1_id,
      user2_id: user2_id
    )
  end

  def inverse_state!(state)
    ActiveRecord::Base.transaction do
      self.update!(state: state)
      f=Friendship.find_or_create_by(
        user_id: self.friend_id,
        friend_id: self.user_id
      )
      f.update!(state: state)
    end
  end

  def should_create_chatroom?
    accepted? && saved_change_to_state?
  end

end
