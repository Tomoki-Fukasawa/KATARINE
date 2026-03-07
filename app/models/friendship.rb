class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend,class_name: "User"
  # has_many :messages
  has_one :chat_room, dependent: :destroy

  enum state: { pending: 0, accepted: 1, rejected: 2 }

  validates :user_id,uniqueness: {scope: :friend_id }
end
