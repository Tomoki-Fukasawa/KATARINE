class Item < ApplicationRecord
  has_many :item_requests, dependent: :destroy
  belongs_to :user
  has_one_attached :image

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
  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :item_state_id
    validates :prefecture_id
  end
  validate :image_presence
  def image_presence
    errors.add(:image) unless image.attached?
  end

  def status_reservation_japanese
    case reservation
    when "available" then "募集中"
    when "reserved" then "受け渡し中"
    when "completed" then "完了"
    end
  end

  def sold_out?
    self.item_requests.where(transfer: :completed).exists?
  end

  # def request_sent?(actor)
  #   self.item_requests.where(sender: actor).exists?
  # end
  
end
