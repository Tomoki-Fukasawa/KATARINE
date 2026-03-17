class ItemRequest < ApplicationRecord

  enum transfer: { waiting: 0, accepted: 1, rejected: 2 ,completed: 3} #順番変えるな厳禁

  belongs_to :item
  belongs_to :sender, class_name: "User"

  validates :item_id,uniqueness: {scope: :sender_id}
  
  def request_accepted!
    return unless user == item.user
    return unless waiting? && item.available?#とにかく、transferがwaitingではない状態であれば、返されることを予測

    ActiveRecord::Base.transaction do
      update!(transfer: :accepted)

      item.item_requests.where.not(id: id).each do |request|
        request.update!(transfer: :rejected)
      end

      item.update!(reservation: :reserved)
    end
  end
  def request_completed!
    return unless accepted?

    transaction do
      update!(transfer: :completed)
      item.update!(reservation: :completed)
    end
  end
  
end
