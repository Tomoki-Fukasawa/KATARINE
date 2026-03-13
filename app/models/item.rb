class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  has_many :item_requests, dependent: :destroy

  belongs_to :user
  has_one_attached :item
end
