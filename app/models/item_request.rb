class ItemRequest < ApplicationRecord

  enum transfer: { waiting: 0, accepted: 1, rejected: 2 ,completed: 3} #順番変えるな厳禁

  belongs_to :item
  belongs_to :sender, class_name: "User"

  validates :item_id,uniqueness: {scope: :sender_id}
  
  def request_accepted!(actor)
    return :not_user unless actor == self.item.user
    return :not_waiting unless self.waiting?  #とにかく、transferがwaitingではない状態であれば、返されることを予測
    return :already_accepted if item.item_requests.where.not(id: id).exists?(transfer: :accepted)

    ActiveRecord::Base.transaction do
      update!(transfer: :accepted)

      item.item_requests.where.not(id: id).each do |request|
        request.update!(transfer: :rejected)
      end
      # item.item_requests.where.not(id: id).update_all(transfer: :rejected)
      # item.item_requests.where.not(id: id).update_all(
      #   transfer: ItemRequest.transfers[:rejected]
      # )

      item.update!(reservation: :reserved)
      :success
    end
  end

  def request_completed!(actor)
    return :not_sender unless actor == self.sender 
    return :not_accepted unless self.accepted?

    transaction do
      update!(transfer: :completed)
      item.update!(reservation: :completed)
      :success
    end
  end
  def request_accepted_cancel(actor)
    return unless actor == self.item.user && self.item.reserved?

    transaction do
      #他のrejectedをwaitingに戻す
      item.item_requests.where(transfer: :rejected).update_all(transfer: :waiting)
      #acceptedをwaitingに戻す
      item.item_requests.where(transfer: :accepted).update!(transfer: :waiting)
      #itemを基に戻す
      item.update!(reservation: :available)
    end
  end

  def status_transfer_japanese
    case transfer
    when "waiting" then "承認待ち"
    when "accepted" then "受け渡し待ち"
    when "rejected" then "見送り"
    when "completed" then "完了"
    end
  end
end
