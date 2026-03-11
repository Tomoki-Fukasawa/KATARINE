class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  has_one_attached :image

  validate :content_or_image_present

  private

  def content_or_image_present
    if content.blank? && !image.attached?
      errors.add(:base, "メッセージを入力してください")
    end
  end
end
