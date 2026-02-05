class Comment < ApplicationRecord
  belongs_to :board
  belongs_to :user

  validates :content, presence: true
end
