require 'rails_helper'

RSpec.describe 'ツイート投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @board_title = Faker::Lorem.sentence
    @board_description = Faker::Lorem.sentence
  end
  context 'ツイート投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with:@user.email
      fill_in 'Password', with:@user.password
      find('input[name="commit"]').click
      expect(page).to have_current_path(authenticated_root_path)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_link('掲示板・ブログを立てる', href: new_board_path)
      # 投稿ページに移動する
      visit new_board_path
      # フォームに情報を入力する
      fill_in 'タイトル', with:@board_title
      fill_in '内容', with:@board_description
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]')click
        sleep 1
      }.to change{Board.count}.by(1) 
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      expect(page).to have_content(@board_title)
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content(@board_description)
    end
  end
  context 'ツイート投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit unauthenticated_root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_link('掲示板・ブログを立てる', href: new_board_path)
    end
  end
end


RSpec.describe 'ツイート編集', type: :system do
  before do
    @board1 = FactoryBot.create(:board)
    @board2 = FactoryBot.create(:board)
  end
  context 'ツイート編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email',with:@board1.user.email
      fill_in 'Password',with:@board1.user.password
      find('input[name="commit"]').click
      expect(page).to have_current_path(authenticated_root_path)
      # ツイート1に「編集」へのリンクがあることを確認する
      expect(
        all('.more')[1].hover
      ).to have_link'edit',href: edit_board_path(@board1)
      # 編集ページへ遷移する
      visit edit_tweet_path(@board1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(page).to have_field('tweet_image', with:@board1.title)
      expect(page).to have_field('tweet_text', with:@board1.description)
      # 投稿内容を編集する
      fill_in 'タイトル',with: "#{@board1.title}+gazourl"
      fill_in '内容',with: "#{@board1.description}+text"
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
        sleep 1
      }.to change{Board.count}.by(0)
      # トップページには先ほど変更した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector ".content_post[style='background-image: url(#{@board1.title}+編集した画像URL);']"
      # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content("#{@board1.description}+編集したテキスト")
    end
  end
  context 'ツイート編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with:@board1.user.email
      fill_in 'Password' with:@board1.user.password
      find('input[name="commit"]').click
      expect(page).to have_current_path(authenticated_root_path)
      # ツイート2に「編集」へのリンクがないことを確認する
      expect(
        all(.more)[0].hover
      ).to have_no_link 'edit',href: edit_tweet_path(@board2)

    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # トップページにいる
      visit unauthenticated_root_path
      # ツイート1に「編集」へのリンクがないことを確認する
      expect(
        all('.more')[1].hover
      ).to have_no_link 'edit', href: edit_board_path(@board1)
      # ツイート2に「編集」へのリンクがないことを確認する
      expect(
        all('.more')[2].hover
      ).to have_no_link 'edit', href: edit_board_path(@board2)
    end
  end
end

RSpec.describe 'ツイート削除', type: :system do
  before do
    @board1 = FactoryBot.create(:board)
    @board2 = FactoryBot.create(:board)
  end
  context 'ツイート削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したツイートの削除ができる' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with:@board.user.email
      fill_in 'Password', with:@board.user.password
      find('input[name="commit"]').click
      expect(page).to have_current_path(authenticated_root_path)
      # ツイート1に「削除」へのリンクがあることを確認する
      expect(
        all('.more')[1].hover
      ).to have_link 'destroy', href:board_path(@board1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        all('.more')[1].hover.find_link('destroy',href: board_path(@board1)).click
        sleep 1
      }.to change{Board.count}.by(-1)
      # トップページにはツイート1の内容が存在しないことを確認する（画像）
      expect(page).to have_no_selector ".content_post[style='background-image: url(#{@board1.title});']"
      # トップページにはツイート1の内容が存在しないことを確認する（テキスト）
      expect(page).to have_no_content("#{@board1.description}")
    end
  end
  context 'ツイート削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの削除ができない' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @board1.user.email
      fill_in 'Password', with: @board1.user.password
      find('input[name="commit"]').click
      expect(page).to have_current_path(authenticated_root_path)
      # ツイート2に「削除」へのリンクがないことを確認する
      expect(
        all('.more')[0].hover
      ).to have_no_link '削除', href: board_path(@board2)
    end
    it 'ログインしていないとツイートの削除ボタンがない' do
      # トップページに移動する
      visit unauthenticated_root_path
      # ツイート1に「削除」へのリンクがないことを確認する
      expect(
        all('.more')[1].hover
      ).to have_no_link 'destroy', href:board_path(@board1)
      # ツイート2に「削除」へのリンクがないことを確認する
      expect(
        all('.more')[0].hover
      ).to have_no_link 'destroy', href:board_path(@board2)
    end
  end
end

RSpec.describe 'ツイート詳細', type: :system do
  before do
    @board = FactoryBot.create(:board)
  end
  it 'ログインしたユーザーはツイート詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
    visit new_user_session_path
    fill_in 'Email' , with:@board.user.email
    fill_in 'Password' with:@board.user.password
    find('input[name="commit"]').click
    expect(page).to have_current_path(authenticated_root_path)
    # ツイートに「詳細」へのリンクがあることを確認する
    expect(
        all('.more')[1].hover
      ).to have_link'show',href: tweet_path(@board)
    # 詳細ページに遷移する
    visit board_path(@board)
    # 詳細ページにツイートの内容が含まれている
    expect(page).to have_selector ".content_post[style='background-image: url(#{@board.title});']"
    expect(page).to have_content("#{@board.description}")
    # コメント用のフォームが存在する
    expect(page).to have_selector 'form'
  end
  it 'ログインしていない状態でツイート詳細ページに遷移できるもののコメント投稿欄が表示されない' do
    # トップページに移動する
    visit unauthenticated_root_path
    # ツイートに「詳細」へのリンクがあることを確認する
    expect(
      all('.more')[0].hover
    ).to have_link'show',href: board_path(@board)
    # 詳細ページに遷移する
    visit board_path(@board)
    # 詳細ページにツイートの内容が含まれている
    expect(page).to have_selector "content_post[style='background-image: url(#{@board.title});']"
    expect(page).to have_content("#{@board.description}")
    # フォームが存在しないことを確認する
    expect(page).to have_no_selector 'form'
    # 「コメントの投稿には新規登録/ログインが必要です」が表示されていることを確認する
    expect(page).to have_content('コメントの投稿には新規登録/ログインが必要')
  end
end