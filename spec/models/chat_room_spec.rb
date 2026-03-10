require 'rails_helper'

RSpec.describe ChatRoom, type: :model do
  before do
    @chat_room = FactoryBot.build(:chat_room)
  end

  describe 'チャットルーム作成' do
    context '作成できる場合' do
      it 'user1とuser2が存在すれば作成できる' do
        expect(@chat_room).to be_valid
      end

      it 'user1_idがuser2_idより大きい場合は入れ替えられる' do
        user_a = FactoryBot.create(:user)
        user_b = FactoryBot.create(:user)

        chat_room = ChatRoom.create(user1: user_b, user2: user_a)

        expect(chat_room.user1_id).to eq([user_a.id, user_b.id].min)
      end
    end

    context '作成できない場合' do
      it 'user1がいないと作成できない' do
        # binding.pry
        @chat_room.user1 = nil
        @chat_room.valid?
        
        expect(@chat_room.errors.full_messages).to include("ユーザー1 を入力してください")
      end

      it 'user2がいないと作成できない' do
        @chat_room.user2 = nil
        @chat_room.valid?
        expect(@chat_room.errors.full_messages).to include("ユーザー2 を入力してください")
      end
    end
  end
end
