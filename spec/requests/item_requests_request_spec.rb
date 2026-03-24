require 'rails_helper'

RSpec.describe "ItemRequests", type: :request do
  include Devise::Test::IntegrationHelpers
  before do
    @userA=FactoryBot.create(:user)
    @userB=FactoryBot.create(:user)
    @userC=FactoryBot.create(:user)
    friendship = FactoryBot.create(:friendship, user: @userA, friend: @userB)
    @item=FactoryBot.create(:item, user:@userA)
  end
  describe "POST items/:item_id/item_requests(.:format)" do
    context "申請者(@userB)がログインしている場合" do
      it "物品譲渡希望申請成功" do
        sign_in @userB
        expect {
          post item_item_requests_path(@item)
        }.to change(ItemRequest, :count).by(1)
        expect(response).to redirect_to(item_path(@item))
      end
    end
    context "出品者(userA)がログインしている場合" do
      it "物品譲渡希望申請失敗" do
        sign_in @userA
        post item_item_requests_path(@item)
        expect(response).to redirect_to(root_path)
      end
    end
  end
  describe "PATCH items/:item_id/item_requests/:id/accept(.:format)" do
    context "更新成功" do
      it "出品者(@userA)が操作して、request_accept!更新成功" do
        sign_in @userA
        item_request=FactoryBot.create(:item_request,sender: @userB, item: @item, transfer: :waiting)
        expect {
          patch accept_item_item_request_path(@item,item_request)
        }.to change{item_request.reload.transfer}.to "accepted"
        expect(response).to redirect_to(item_path(item_request.item))
        expect(flash[:notice]).to eq "承認しました"
      end
    end
    context "更新失敗" do
      it "申請者(@userB)が操作して、request_accept!更新失敗" do
        sign_in @userB
        item_request=FactoryBot.create(:item_request,sender: @userB, item: @item, transfer: :waiting)
        patch accept_item_item_request_path(@item,item_request)
        expect(response).to redirect_to(item_path(item_request.item))
        expect(flash[:alert]).to eq "itemの所有者ではありません"
      end
      it "すでにacceptが存在する場合に、他の申請者をacceptできない" do
        item_request=FactoryBot.create(:item_request,sender: @userB, item: @item, transfer: :accepted)
        item_request2=FactoryBot.create(:item_request,sender: @userC, item: @item, transfer: :waiting)
        sign_in @userA
        expect{
          patch accept_item_item_request_path(@item,item_request2)
        }.not_to change{item_request2.reload.transfer}
        expect(item_request2.reload).to be_waiting
        expect(response).to redirect_to(item_path(item_request2.item))
        expect(flash[:alert]).to eq "他のユーザーが先に承認しました"
      end
    end
  end
  describe "PATCH items/:item_id/item_requests/:id/complete(.:format)" do
    context "更新成功" do
      it "申請者(@userB)が操作して、request_complete!更新成功" do
        sign_in @userB
        item_request=FactoryBot.create(:item_request,sender: @userB, item: @item, transfer: :accepted)
        expect {
          patch complete_item_item_request_path(@item,item_request)
        }.to change{item_request.reload.transfer}.to "completed"
        expect(response).to redirect_to(item_path(item_request.item))
        expect(flash[:notice]).to eq "完了しました"
      end
    end
    context "更新失敗" do
      it "出品者(@userA)が操作して、request_complete!更新失敗" do
        sign_in @userA
        item_request=FactoryBot.create(:item_request,sender: @userB, item: @item, transfer: :accepted)
        patch complete_item_item_request_path(@item,item_request)
        expect(response).to redirect_to(item_path(item_request.item))
        expect(flash[:alert]).to eq "申請者ではありません"
      end
      it "transferがaccepted以外の状態で、request_complete!は状態を変更しない" do
        sign_in @userB
        item_request=FactoryBot.create(:item_request,sender: @userB, item: @item, transfer: :waiting)
        expect{
          patch complete_item_item_request_path(@item,item_request)
        }.not_to change{item_request.reload.transfer}
        expect(item_request.reload).to be_waiting
        expect(response).to redirect_to(item_path(item_request.item))
      end
    end
  end
end
