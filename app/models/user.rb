class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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
  validates :image, presence: true
  validates :email, presence: true
  validates :password, 
    presence: true,
    format: {
      with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, 
      message: 'には英字と数字の両方を含めて設定してください'
    },if: :password_required?

  validates :greet, length: {maximum: 200}
  validates :introduction, length: { maximum: 500}

  has_many :items
  has_many :buyers
  has_one_attached :image
  has_many :boards
  has_many :comments

  has_many :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"

  has_many :friends, 
  ->{where(friendships: { state: :accepted})},
  through: :friendships, 
  source: :friend

  has_many :inverse_friends,
  ->{where(friendships: { state: :accepted})},
  through: :inverse_friendships,
  source: :user

  def pending_sent_to?(user)
    friendships.exists?(friend_id: user.id, state: :pending)
  end

  def pending_received_from?(user)
    inverse_friendships.exists?(user_id: user.id, state: :pending)
  end

  def friends_with?(user)
    friendships.exists?(friend_id: user.id, state: :accepted) ||
      inverse_friendships.exists?(user_id: user.id, state: :accepted)
  end
  
  has_many :chat_rooms_as_user1,
    class_name: "ChatRoom",
    foreign_key: :user1_id

  has_many :chat_rooms_as_user2,
    class_name: "ChatRoom",
    foreign_key: :user2_id
end
