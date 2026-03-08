class ChatRoom < ApplicationRecord
  belongs_to :user1, class_name: "User"
  belongs_to :user2, class_name: "User"

  # belongs_to :friendship,dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :user1_id, uniqueness: { scope: :user2_id }

  before_validation :sort_users

  def partner(user)
    user == user1 ? user2 : user1
  end
  
  private

  def sort_users
    return unless user1_id && user2_id

    if user1_id > user2_id
      self.user1_id, self.user2_id = user2_id, user1_id
    end
  end

end