
require 'rails_helper'

RSpec.describe "Friendships", type: :request do
  include Devise::Test::IntegrationHelpers
  before do
    @userA=FactoryBot.create(:user)
    @userB=FactoryBot.create(:user)
  end
  describe "POST/friendships" do
    # it "友達申請成功" do
    #   sign_in @userA
    #   get user_path(@userB)
    #   post friendships_path, params: {friend_id: @userB.id}
    #   expect(response).to redirect_to(root_path)
    # end
    # it "友達申請失敗"
    # end
    context "ログインしている場合" do
      it "友達申請成功" do
        sign_in @userA
        expect {
          post friendships_path, params: { friend_id: @userB.id }
        }.to change(Friendship, :count).by(1)
        expect(response).to redirect_to(friends_user_path(@userA))
      end
    end
    context "未ログインの場合" do
      it "リダイレクトされる" do
        post friendships_path, params: { friend_id: @userB.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
  describe "PUT/Friendships/:id" do
    # it "友達申請承認" do
    #   sign_in @userA
    #   patch friendship_path,params:{friend_id:@userB.id}
    #   expect(response).to redirect_to(root_path)
    # end
    it "友達申請承認" do
      # ① 先に申請を作る
      friendship = FactoryBot.create(
        :friendship,
        user: @userA,
        friend: @userB,
        state: :pending
      )

      # ② 受け取る側がログイン
      sign_in @userB

      # expect {
      patch friendship_path(friendship)
      # }.to change(Friendship, :count).by(1) # acceptedの逆向きが増える

      expect(friendship.reload.state).to eq("accepted")
      expect(response).to redirect_to(friends_user_path(@userB))
    end
  end

  describe "PATCH/friendships/:id/reject" do
    it "友達申請拒否" do
      friendship = FactoryBot.create(
        :friendship,
        user: @userA,
        friend: @userB,
        state: :pending
      )

      sign_in @userB

      patch reject_friendship_path(friendship)

      expect(friendship.reload.state).to eq("rejected")
      expect(response).to redirect_to(friends_user_path(@userB))
    end
  end

  
end