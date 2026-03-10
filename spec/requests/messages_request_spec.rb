require 'rails_helper'

RSpec.describe "Messages", type: :request do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)

    @chat_room = FactoryBot.create(
      :chat_room,
      user1: @user1,
      user2: @user2
    )
  end

  describe "POST /chat_rooms/:chat_room_id/messages" do
    it "メッセージを作成できる" do
      sign_in @user1

      expect{
        post chat_room_messages_path(@chat_room), params: {
          message: { content: "こんにちは" }
        }
      }.to change(Message, :count).by(1)

      expect(response).to redirect_to(chat_room_path(@chat_room))
    end
    it "contentもimageもないと作成できない" do
      sign_in @user1

      expect{
        post chat_room_messages_path(@chat_room), params: {
          message: { content: "" }
        }
      }.not_to change(Message, :count)
    end
  end
end