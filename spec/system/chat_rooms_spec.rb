require 'rails_helper'

RSpec.describe 'チャットルーム表示', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)

    FactoryBot.create(
      :friendship,
      user: @user1,
      friend: @user2,
      state: :accepted
    )

    FactoryBot.create(
      :friendship,
      user: @user2,
      friend: @user1,
      state: :accepted
    )

    @chat_room = FactoryBot.create(
      :chat_room,
      user1: @user1,
      user2: @user2
    )
  end

  it 'チャットルームが表示される' do
    sign_in(@user1)

    visit chat_room_path(@chat_room)

    expect(page).to have_content(@user2.nickname)
  end
  it '自分のチャット一覧が表示される' do
    sign_in(@user1)

    visit chat_rooms_path

    expect(page).to have_content(@user2.nickname)
  end
end
