require 'rails_helper'

RSpec.describe "Boards", type: :request do
  before do
    @board = FactoryBot.create(:board)
  end
  describe "GET #index" do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する' do 
    end
  end
end
