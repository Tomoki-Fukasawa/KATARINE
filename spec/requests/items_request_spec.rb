require 'rails_helper'

RSpec.describe "Items", type: :request do
  include Devise::Test::IntegrationHelpers
  before do
    @userA=FactoryBot.create(:user)
    @userB=FactoryBot.create(:user)
    friendship = FactoryBot.create(:friendship, user: @userA, friend: @userB)
    @item=FactoryBot.create(:item)
  end
  describe "GET/" doe
  end
  

end
