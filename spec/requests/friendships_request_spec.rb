
require 'rails_helper'

RSpec.describe "Friendships", type: :request do
  before do
    @userA=FactoryBot.create(:user)
    @userB=FactoryBot.create(:user)
    @friendship = FactoryBot.create(:friendship)
  end

  
end