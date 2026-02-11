require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @board1 = FactoryBot.create(:board, user: @user1)
    @comment = Faker::Lorem.sentence
    sign_in @user1
  end

  it 'ログインしたユーザーは掲示板詳細ページでコメント投稿できる' do
    
    # ツイート詳細ページに遷移する
    sign_in @user1
    visit board_path(@board1)
    expect(page).to have_field('コメント')
    # フォームに情報を入力する
    fill_in 'コメント', with:@comment
    # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
    # expect{
      click_button 'SEND'
    #   sleep 1
    # }.to change{Comment.count}.by(1)
    # 詳細ページにリダイレクトされることを確認する
    expect(page).to have_current_path(board_path(@board1))
    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content @comment
  end
end
