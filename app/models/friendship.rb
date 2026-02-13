class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend,class_name: "User"
  has_many :messages

  enum state: { pending: 0, accepted: 1, rejected: 2 }

  validates :user_id,uniqueness: {scope: :friend_id }
end
