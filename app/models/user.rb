class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_format_of :password, with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'には英字と数字の両方を含めて設定してください'
  with_options presence: { message: 'を入力してください' } do
    validates :nickname
    validates :first_name_kanji
    validates :last_name_kanji
    validates :first_name_kana
    validates :last_name_kana
    validates :birth_day
  end
  with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: '全角文字を使用してください' } do
    validates :first_name_kanji
    validates :last_name_kanji
  end
  with_options format: { with: /\A[ァ-ヶー]+\z/, message: '全角文字カタカナを使用してください' } do
    validates :first_name_kana
    validates :last_name_kana
  end

  has_many :items
  has_many :buyers
  has_one_attached :image
end
