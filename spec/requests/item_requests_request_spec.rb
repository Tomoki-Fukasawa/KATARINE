require 'rails_helper'

RSpec.describe "ItemRequests", type: :request do
  include Devise::Test::IntegrationHelpers
  before do
    @userA=FactoryBot.create(:user)
    @userB=FactoryBot.create(:user)
    friendship = FactoryBot.create(:friendship, user: @userA, friend: @userB)
    @item=FactoryBot.create(:item, user:@userA)
    # @item_request=FactoryBot.create(:item_request,sender: @userA, item: @item)
  end
  describe "POST items/:item_id/item_requests(.:format)" do
    context "出品者以外がログインしている場合" do
      it "物品譲渡希望申請成功"
        sign_in @userB
        expect {
          post item_requests_path(@item), params: {item: @item,sender: @userA.id}
        }.to change(ItemRequest, :count).by(1)
        expect(response).to redirect_to(item_path(@item))
      end
    end
    context "出品者がログインしている場合" do
      it "物品譲渡希望申請失敗" do
        sign_in @userA
        post item_requests_path(@item), params: { friend_id: @userB.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end
  describe "PATCH items/:item_id/item_requests/:id/accept(.:format)" do
    context "出品者が操作して、request_accept!更新成功" do
      sign_in @userB
      item_request=FactoryBot.create(:item_request,sender: @userA, item: @item, transfer: :waiting)
      expect {
        patch accept_item_item_request_path(@item,item_request), params: {item: @item,sender: @userB}
      }.to change(item_request, :transfer).to be_accepted
      expect(response).to redirect_to(item_path(@item))
    end
    context "出品者以外が操作して、request_accept!更新失敗" do
      sign_in @userA
      patch accept_item_item_request_path(@item,item_request), params: {item: @item,sender: @userB}
      expect(response).to redirect_to(root_path)
    end
  end
  describe "PATCH items/:item_id/item_requests/:id/complete(.:format)" do
    context "出品者以外が操作して、request_complete!更新成功" do
      sign_in @userA
      item_request=FactoryBot.create(:item_request,sender: @userB, item: @item, transfer: :accepted)
      expect {
        patch complete_item_item_request_path(@item,item_request), params: {item: @item,sender: @userB}
      }.to change(item_request, :transfer).to be_completed
    end
    context "出品者が操作して、request_complete!更新失敗" do
      sign_in @userB
      patch complete_item_item_request_path(@item,item_request), params: {item: @item,sender: @userB}
      expect(response).to redirect_to(root_path)
    end
  end
end
