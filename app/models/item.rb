class Item < ApplicationRecord
  has_many :item_requests, dependent: :destroy
  belongs_to :user
  has_one_attached :item

  enum reservation: { available: 0, reserved: 1, completed: 2}

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_state
  belongs_to :prefecture
  
  with_options presence: { message: 'を入力してください' } do
    validates :item_name
    validates :item_script
  end
  validates :item_name, length: { maximum: 40, message: '40字以内で記述してください' }
  validates :item_script, length: { maximum: 1000, message: '1000字以内で記述してください' }
  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :item_state_id
    validates :prefecture_id
  end
  validate :image_presence
  def image_presence
    errors.add(:image, 'を添付してください') unless image.attached?
  end
end
