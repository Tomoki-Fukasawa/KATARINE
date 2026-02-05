require 'rails_helper'

RSpec.describe Board, type: :model do
  before do
    @board = FactoryBot.build(:board)
  end

  describe '掲示板の保存' do
    context '掲示板が投稿できる場合' do
      it 'タイトルと説明文を投稿できる' do
        expect(@board).to be_valid
      end
    end
    context '掲示板が投稿できない場合' do
      it 'タイトルが空では投稿できない' do
        @board.title=''
        @board.valid?
        expect(@board.errors.full_messages).to include("タイトル を入力してください")
      end
      it '説明文が空では投稿できない' do
        @board.description=''
        @board.valid?
        expect(@board.errors.full_messages).to include("説明文 を入力してください")
      end
      it 'ユーザーが紐付いていなければ投稿できない' do
        @board.user=nil
        @board.valid?
        expect(@board.errors.full_messages).to include("User が空です")
      end
    end
  end    
end
