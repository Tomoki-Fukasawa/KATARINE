require 'rails_helper'

RSpec.describe "Users", type: :request do
  include Devise::Test::IntegrationHelpers
  before do
    @userA = FactoryBot.create(:user)
    @userB = FactoryBot.create(:user)
  end
  describe "GET /" do
    it "未ログインでもトップページにアクセスできる" do
      get root_path
      expect(response).to have_http_status(:ok)
    end
    it "未ログインでもuser#showページにアクセスできる" do
      get user_path(@userA)
      expect(response).to have_http_status(:ok)
    end
  end
  describe "PATCH /users/:id/friend_want" do
    let(:user) { FactoryBot.create(:user) }

    it "未ログインではリダイレクトされる" do
      patch friend_want_user_path(@userA)
      expect(response).to redirect_to(new_user_session_path)
    end
    it "ログインしていれば実行できる" do
      sign_in @userA
      patch friend_want_user_path(@userA)
      expect(response).to redirect_to(user_path(@userA))
    end
  end
  describe "GET /users/:id/friends" do
    it "未ログインでは友達一覧サイトからリダイレクトされる" do
      get  friends_user_path(@userA)
      expect(response).to redirect_to(new_user_session_path)
    end
    it "ログインしていれば閲覧できる" do
      sign_in @userA
      get friends_user_path(@userA)
      expect(response).to have_http_status(:ok)
    end
  end
  
end
