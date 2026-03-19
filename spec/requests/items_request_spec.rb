require 'rails_helper'

RSpec.describe "Items", type: :request do
  include Devise::Test::IntegrationHelpers
  before do
    @userA=FactoryBot.create(:user)
    @userB=FactoryBot.create(:user)
    friendship = FactoryBot.create(:friendship, user: @userA, friend: @userB)
    @item=FactoryBot.create(:item)
  end
  describe "GET/" do
    it 'ログインしているとトップページにアクセスできる' do
      sign_in @userA
      get root_path
      expect(response).to have_http_status(:ok)
    end
    it '未ログインだとトップページにアクセスできない' do
      get root_path
      expect(response).to redirect_to(root_path)
    end
  end
  

end
