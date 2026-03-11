require 'rails_helper'

RSpec.describe 'メッセージ投稿', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @chat_room = FactoryBot.create(:chat_room, user1: @user1, user2: @user2)

    FactoryBot.create(:friendship, user: @user1, friend: @user2, state: :accepted)
    FactoryBot.create(:friendship, user: @user2, friend: @user1, state: :accepted)

    sign_in @user1
    visit chat_room_path(@chat_room)
  end

  context 'メッセージ送信できる場合' do
    it '一覧からチャットルームへ遷移できる' do
      visit chat_rooms_path
      click_link 'この人と会話する'

      expect(page).to have_current_path(chat_room_path(@chat_room))
    end
    it 'contentを入力すると投稿できる' do
      fill_in 'message_content', with: 'こんにちは'

      expect do
        click_button '送信'
      end.to change(Message, :count).by(1)

      expect(page).to have_content 'こんにちは'
    end
    it '画像のみでも投稿できる' do
      attach_file 'message_image', Rails.root.join('spec/fixtures/files/test_image.png'), make_visible: true

      expect do
        click_button '送信'
      end.to change(Message, :count).by(1)
      
    end
  end

  context 'メッセージ送信できない場合' do
    it 'contentもimageもないと投稿できない' do
      # expect{
      #   click_button '送信'
      # }.not_to change{ Message.count }
      expect do
        click_button '送信'
      end.not_to change(Message, :count)
    end
  end
end