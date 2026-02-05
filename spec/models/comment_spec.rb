require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメントの保存' do
    context 'コメントが投稿できる場合' do
      it 'コメントを投稿できる' do
        expect(@comment).to be_valid
      end
    end
    context 'コメントが投稿できない場合' do
      it '内容が空では投稿できない' do
        @comment.content=''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("内容 を入力してください")
      end
  
      it 'ユーザーが紐付いていなければ投稿できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("User が空です")
      end
      it 'boardが紐付いていなければ投稿できない' do
        @comment.board = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Board が空です")
      end
    end
  end
end
