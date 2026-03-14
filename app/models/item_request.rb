class ItemRequest < ApplicationRecord

  enum transfer: { waiting: 0, accepted: 1, rejected: 2 , canceled: 3,completed: 4}

  belongs_to :item
  belongs_to :sender, class_name: "User"

  belongs_to :receiver, class_name: "User", optional: true

  belongs_to :user
end
