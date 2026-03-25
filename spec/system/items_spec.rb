require 'rails_helper'

RSpec.describe "Items", type: :system do
  before do
    @userA=FactoryBot.create(:user)
    @userB=FactoryBot.create(:user)
    friendship = FactoryBot.create(:friendship, user: @userA, friend: @userB)
    @item=FactoryBot.create(:item)
    @item_name=Faker::Lorem.sentence
    @item_script=Faker::Lorem.sentence
  end

  describe "出品" do
    it "item作成成功" do
      sign_in @userA
      visit mypage_path
      expect(page).to have_link('物品出品はこちらから', href: new_item_path)
      visit new_item_path
      expect(page).to have_content('物品の情報を入力')
      fill_in '商品名', with:@item_name
      fill_in '商品の説明', with:@item_script
      fill_in 'カテゴリー', with:@item.category
      fill_in '商品の状態', with:@item.item_state
      fill_in '受け渡す地域', with:@item.prefecture
      click_button '出品する'
      visit mypage_path
      expect(page).to have_content(@item.item_name)
      expect(page).to have_content(@item.item_script)
    end
    it "item作成失敗" do
      visit mypage_path
      expect(page).to have_no_link('物品出品はこちらから', href: new_item_path)
    end
  end
  describe "詳細表示" do
    it "出品したitemのデータが表示される" do
      sign_in @userA
      visit item_path(@userA.item)
    end
  end
  describe "update" do
    it "作成者のみ更新できる" do
      sign_in @userA
      visit edit_item_path(@userA.item)
    end
    it "他者は更新できない" do
      sign_in @userB
      visit edit_item_path(@userA.item)
    end
  end
end
