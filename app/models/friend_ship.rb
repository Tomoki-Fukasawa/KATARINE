class FriendShip < ApplicationRecord
  belongs_to :user
  belongs_to :friend,class_name: "User"
  has_many :messages

  validates :user_id,uniqueness: {scope: :friend_id }
end
