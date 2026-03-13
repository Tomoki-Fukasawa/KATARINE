class ItemRequest < ApplicationRecord

  enum state: { waiting: 0, accepted: 1, rejected: 2 , completed: 3}
  # enum state: { waiting: 0, accepted: 1, rejected: 2 , shipping: 3,completed: 4}

  belongs_to :item
  belongs_to :sender, class_name: "User"

  belongs_to :receiver, class_name: "User", optional: true

  has_one :address, dependent: :destroy
end
