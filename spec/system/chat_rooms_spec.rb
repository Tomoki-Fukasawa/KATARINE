require 'rails_helper'

RSpec.describe 'チャットルーム削除', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)

    @chat_room = FactoryBot.create(
      :chat_room,
      user1: @user1,
      user2: @user2
    )

    FactoryBot.create_list(
      :message,
      5,
      chat_room: @chat_room,
      user: @user1
    )
  end

  it 'チャットを削除するとメッセージも削除される' do
    # ログイン
    sign_in(@user1)

    # チャットルームへ
    visit chat_room_path(@chat_room)

    expect(@chat_room.messages.count).to eq(5)

    expect{
      click_on 'チャットを終了'
    }.to change{ Message.count }.by(-5)

    expect(page).to have_current_path(root_path)
  end
end
