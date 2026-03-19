require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品' do
    context '商品出品できるとき' do
      it '必要な情報を記述すれば、商品を出品できる' do
        expect(@item).to be_valid
      end
    end
    context '商品出品できないとき' do
      it '商品画像がないと、出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Image を添付してください')
      end
      it 'item_nameが空では出品できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Item name を入力してください')
      end
      it 'item_nameが40字より多いと出品できない' do
        @item.item_name = Faker::Lorem.characters(number: 41)
        @item.valid?
        expect(@item.errors.full_messages).to include('Item name 40字以内で記述してください')
      end
      it 'item_scriptが空では出品できない' do
        @item.item_script = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Item script を入力してください')
      end
      it 'item_scriptが1000字より多いと出品できない' do
        @item.item_script = Faker::Lorem.characters(number: 1001)
        @item.valid?
        expect(@item.errors.full_messages).to include('Item script 1000字以内で記述してください')
      end
      it 'カテゴリーが選択されていないと、出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品状態が選択されていないと、出品できない' do
        @item.item_state_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Item state can't be blank")
      end
      it '発送元地域が選択されていないと、出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Region can't be blank")
      end
      it 'reservationが正しく設定されること' do
        expect(@item).to be_available
      end
      it 'status_reservation_japaneseが正しく返る' do
        expect(@item.status_reservation_japanese).to eq('募集中')
      end
      it 'userが紐づいていないと、出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end

end
