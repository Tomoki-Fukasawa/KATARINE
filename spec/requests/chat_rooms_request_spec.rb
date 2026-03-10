require 'rails_helper'

RSpec.describe "ChatRooms", type: :request do
  describe "GET /chat_rooms" do
    it "一覧ページが表示される" do
      sign_in @user1

      get chat_rooms_path

      expect(response).to have_http_status(:ok)
    end
  end
end
