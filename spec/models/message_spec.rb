require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
      @message = FactoryBot.build(:message, :with_image)
      # @message.image.attach(io: File.open(Rails.root.join('spec/fixtures/test_image.png')), filename: 'test_image.png', content_type: 'image/png')
  end

  describe 'メッセージ投稿' do
    context 'メッセージが投稿できる場合' do
      it 'contentとimageが存在していれば保存できる' do
        expect(@message).to be_valid
      end
      it 'contentが空でも保存できる' do
        @message.content=''
        expect(@message).to be_valid
      end
      it 'imageが空でも保存できる' do
        @message.image.detach
        expect(@message).to be_valid
      end

      
    end
    context 'メッセージが投稿できない場合' do
      it 'contentとimageが空では保存できない' do
        @message.content=''
        @message.image.purge if @message.image.attached?
        @message.valid?
        expect(@message.errors.full_messages).to include("メッセージを入力してください")      end
      it 'roomが紐付いていないと保存できない' do
        @message.chat_room = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("チャットルーム が存在しません")
        
      end
      it 'userが紐付いていないと保存できない' do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("ユーザー が存在しません")
      end
    end
  end
end
