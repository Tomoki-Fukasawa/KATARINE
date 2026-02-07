require 'rails_helper'

RSpec.describe "Boards", type: :request do
  before do
    @board = FactoryBot.create(:board)
  end
  describe "GET #index" do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get unauthenticated_root_path
      expect(response.status).to eq 200      
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する' do 
      get unauthenticated_root_path
      expect(response.body).to include(@board.title)      
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートの画像URLが存在する' do 
      get unauthenticated_root_path
      expect(response.body).to include(@board.description)
    end
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get authenticated_root_path
      expect(response.status).to eq 200      
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する' do 
      get authenticated_root_path
      expect(response.body).to include(@board.title)      
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートの画像URLが存在する' do 
      get authenticated_root_path
      expect(response.body).to include(@board.description)
    end
  end
  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get board_path(@board)
      expect(response.status).to eq 200
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する' do 
      get board_path(@board)
      expect(response.body).to include(@board.title)
    end
    it 'showアクションにリクエストするとレスポンスに投稿済みのツイートの画像URLが存在する' do 
      get board_path(@board)
      expect(response.body).to include(@board.description)
    end
    it 'showアクションにリクエストするとレスポンスにコメント一覧表示部分が存在する' do 
      get board_path(@board)
      expect(response.body).to include('board-list')
    end
  end  
end
