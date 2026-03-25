require 'rails_helper'

RSpec.describe "ItemRequests", type: :system do
  before do
    @userA=FactoryBot.create(:user)
    @userB=FactoryBot.create(:user)
    friendship = FactoryBot.create(:friendship, user: @userA, friend: @userB)
    @item=FactoryBot.create(:item)
  end
  
  describe "申請" do
    sign_in @userB
    visit
  end
  describe "承認" do
    sign_in @userA
    visit 
  end
  describe "完了" do
    sign_in @userB
    visit 
  end
end
