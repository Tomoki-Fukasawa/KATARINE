require 'rails_helper'

RSpec.describe ItemRequest, type: :model do
  describe 'ItemRequest' do
  before do
    @item_request = FactoryBot.build(:item_request)
  end

  describe 'バリデーション' do
    it '正常に保存できる' do
      user = FactoryBot.create(:user)
      friend = FactoryBot.create(:user)
      item=FactoryBot.create(:item, user: user)
      item_request=FactoryBot.create(:item_request, sender: friend,item: item)
      expect(item_request).to be_valid
    end
    it '重複申請はできない' do
      user = FactoryBot.create(:user)
      friend = FactoryBot.create(:user)
      item=FactoryBot.create(:item, user: user)
      item_request=FactoryBot.create(:item_request, sender: friend,item: item)
      item_request2=FactoryBot.build(:item_request, sender: friend,item: item)
      expect(item_request2).not_to be_valid
    end
  end

  describe '状態遷移' do
     it '初期状態がwaitingである' do
      item_request=FactoryBot.create(:item_request)
      expect(item_request).to be_waiting
    end
    it 'waitingからacceptedにできる' do
      user = FactoryBot.create(:user)
      friend = FactoryBot.create(:user)
      friend2 = FactoryBot.create(:user)
      item=FactoryBot.create(:item, user: user, reservation: :available)
      item_request=FactoryBot.create(:item_request, item: item,sender:friend,transfer: :waiting)
      item_request2=FactoryBot.create(:item_request, item: item,sender: friend2,transfer: :waiting)
      item_request.request_accepted!(user)
      expect(item).to be_reserved
      expect(item_request).to be_accepted
      expect(item_request2).to be_rejected
    end
    it 'acceptedからcompletedにできる' do
      user = FactoryBot.create(:user)
      friend = FactoryBot.create(:user)
      item=FactoryBot.create(:item, user: user,reservation: :reserved)
      item_request=FactoryBot.create(:item_request, item: item,sender:friend, transfer: :accepted)
      item_request.request_completed!(friend)
      expect(item_request).to be_completed
      expect(item).to be_completed
    end
  end
  describe '状態遷移失敗' do
    it '出品者以外のuserはwaitingからacceptedにできない' do
      user = FactoryBot.create(:user)
      user2 =FactoryBot.create(:user)
      friend = FactoryBot.create(:user)
      friend2 = FactoryBot.create(:user)
      item=FactoryBot.create(:item, user: user, reservation: :available)
      item_request=FactoryBot.create(:item_request, item: item,sender:friend,transfer: :waiting)
      item_request2=FactoryBot.create(:item_request, item: item,sender: friend2,transfer: :waiting)
      item_request.request_accepted!(user2)
      expect(item).to be_available
      expect(item_request).to be_waiting
      expect(item_request2).to be_waiting
    end
    it '受け取り申請者以外のuserはacceptedからcompletedにできない' do
      user = FactoryBot.create(:user)
      user2 =FactoryBot.create(:user)
      friend = FactoryBot.create(:user)
      item=FactoryBot.create(:item, user: user,reservation: :reserved)
      item_request=FactoryBot.create(:item_request, item: item,sender:friend, transfer: :accepted)
      item_request.request_completed!(user2)
      expect(item_request).to be_accepted
      expect(item).to be_reserved
    end
  end
  describe '状態遷移中断' do
    it "自分のwaitingリクエストは削除できる" do
      user = FactoryBot.create(:user)
      friend = FactoryBot.create(:user)
      item=FactoryBot.create(:item, user: user, reservation: :available)
      item_request=FactoryBot.create(:item_request, item: item,sender:friend,transfer: :waiting)
      expect{
        item_request.destroy
      }.to change(ItemRequest, :count).by(-1)
    end

    it "acceptedをキャンセルすると他がwaitingに戻る" do
      user = FactoryBot.create(:user)
      user2 =FactoryBot.create(:user)
      friend = FactoryBot.create(:user)
      friend2 = FactoryBot.create(:user)
      item=FactoryBot.create(:item, user: user, reservation: :available)
      item_request=FactoryBot.create(:item_request, item: item,sender:friend,transfer: :waiting)
      item_request2=FactoryBot.create(:item_request, item: item,sender: friend2,transfer: :waiting)
      item_request.request_accepted!(user)
      item_request.request_accepted_cancel(user)
      expect(item.reload).to be_available
      expect(item_request.reload).to be_waiting
      expect(item_request2.reload).to be_waiting
    end
  end
end
