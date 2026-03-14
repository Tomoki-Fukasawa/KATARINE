class Item < ApplicationRecord

  enum state: { available: 0, reserved: 1}

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  has_many :item_requests, dependent: :destroy

  belongs_to :user
  has_one_attached :item
end
