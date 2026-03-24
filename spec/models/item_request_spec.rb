require 'rails_helper'

RSpec.describe ItemRequest, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @friend = FactoryBot.create(:user)
    @item=FactoryBot.create(:item, user: @user, reservation: :available)
    @item_request = FactoryBot.create(:item_request, sender: @friend,item: @item,transfer: :waiting)
  end

  context 'バリデーション' do
    it '正常に保存できる' do
      expect(@item_request).to be_valid
    end
    it '重複申請はできない' do
      item_request2=FactoryBot.build(:item_request, sender: @friend,item: @item)
      expect(item_request2).not_to be_valid
    end
  end

  context '状態遷移' do
    it '初期状態がwaitingである' do
      expect(@item_request).to be_waiting
    end
    it 'waitingからacceptedにできる' do
      friend2 = FactoryBot.create(:user)
      item_request2=FactoryBot.create(:item_request, item: @item,sender: friend2,transfer: :waiting)
      @item_request.request_accepted!(@user)
      expect(@item).to be_reserved
      expect(@item_request).to be_accepted
      expect(item_request2.reload).to be_rejected
    end
    it 'acceptedからcompletedにできる' do
      @item_request.request_accepted!(@user)
      @item_request.request_completed!(@friend)
      expect(@item_request).to be_completed
      expect(@item).to be_completed
    end
  end
  describe '状態遷移失敗' do
    it '出品者以外のuserはwaitingからacceptedにできない' do
      user2 =FactoryBot.create(:user)
      friend2 = FactoryBot.create(:user)
      item_request2=FactoryBot.create(:item_request, item: @item,sender: friend2,transfer: :waiting)
      @item_request.request_accepted!(user2)
      expect(@item).to be_available
      expect(@item_request).to be_waiting
      expect(item_request2).to be_waiting
    end
    it '受け取り申請者以外のuserはacceptedからcompletedにできない' do
      user2 =FactoryBot.create(:user)
      # item2=FactoryBot.create(:item, user: @user,reservation: :reserved)
      @item_request.request_accepted!(@user)
      @item_request.request_completed!(user2)
      expect(@item_request).not_to be_completed
      expect(@item).to be_reserved
    end
  end
  context '状態遷移中断' do
    it "自分のwaitingリクエストは削除できる" do
      expect{
        @item_request.destroy
      }.to change(ItemRequest, :count).by(-1)
    end

    it "acceptedをキャンセルすると他がwaitingに戻る" do
      user2 =FactoryBot.create(:user)
      friend2 = FactoryBot.create(:user)
      item_request2=FactoryBot.create(:item_request, item: @item,sender: friend2,transfer: :waiting)
      @item_request.request_accepted!(@user)
      @item_request.request_accepted_cancel(@user)
      expect(@item.reload).to be_available
      expect(@item_request.reload).to be_waiting
      expect(item_request2.reload).to be_waiting
    end
  end
end
