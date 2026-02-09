require 'rails_helper'

RSpec.describe '掲示板投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @board_title = Faker::Lorem.sentence
    @board_description = Faker::Lorem.sentence
  end
  context 'ツイート投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with:@user.email
      fill_in 'パスワード', with:@user.password
      find('input[name="commit"]').click
      expect(page).to have_current_path(root_path)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_link('掲示板・ブログを立てる', href: new_board_path)
      # 投稿ページに移動する
      visit new_board_path
      expect(page).to have_content('新規投稿ページ')
      # フォームに情報を入力する
      fill_in '投稿タイトル', with:@board_title
      fill_in '投稿内容', with:@board_description
      # 送信するとBoardモデルのカウントが1上がることを確認する
      # expect{
        # find('input[name="commit"]').click
        click_button '掲示板を公開する'
        expect(page).to have_content(@board_title)
        expect(page).to have_content(@board_description)
      # }.to change{Board.count}.by(1) 
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（画像）
      expect(page).to have_content(@board_title)
      # トップページには先ほど投稿した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content(@board_description)
    end
  end
  context 'ツイート投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_link('掲示板・ブログを立てる', href: new_board_path)
    end
  end
end


RSpec.describe '掲示板編集', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @board1 = FactoryBot.create(:board, user: @user)
    @board2 = FactoryBot.create(:board)
  end
  context '掲示板編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したツイートの編集ができる' do
      # 掲示板1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス',with:@user.email
      fill_in 'パスワード',with:@user.password
      find('input[name="commit"]').click
      expect(page).to have_current_path(root_path)
      # 掲示板1に「'この掲示板についてはこちら'」へのリンクがあることを確認する
      within all('.board-list')[0]do
        expect(page).to have_link 'この掲示板についてはこちら'
      end
      # 詳細ページへ遷移する
      visit board_path(@board1)
      # 掲示板編集のリンクがあることを確認・移動
      within '.more' do
        click_link '編集'
      end
      #掲示板編集の画面に移動後、
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(page).to have_current_path(edit_board_path(@board1))      
      expect(page).to have_field('投稿タイトル', with:@board1.title)
      expect(page).to have_field('投稿内容', with:@board1.description)
      # 投稿内容を編集する
      fill_in '投稿タイトル',with: "#{@board1.title}+編集したtitle"
      fill_in '投稿内容',with: "#{@board1.description}+編集したdescription"
      # 編集してもBoardモデルのカウントは変わらないことを確認する
      expect{
        # find('input[name="commit"]').click
        click_button '掲示板を更新する'
      }.to change{Board.count}.by(0)
      # トップページには先ほど変更した内容の掲示板が存在することを確認する（タイトル）
      # expect(page).to have_selector ".content_post[style='background-image: url(#{@board1.title}+編集した画像URL);']"
      expect(page).to have_content("#{@board1.title}+編集したtitle")
      # トップページには先ほど変更した内容のツイートが存在することを確認する（説明文）
      expect(page).to have_content("#{@board1.description}+編集したdescription")
    end
  end
  context '掲示板編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した掲示板の編集画面には遷移できない' do
      # 掲示板1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with:@user.email
      fill_in 'パスワード', with:@user.password
      find('input[name="commit"]').click
      expect(page).to have_current_path(root_path)
      # 詳細ページへ遷移する
      visit board_path(@board2)
      # 掲示板2に「'編集'」へのリンクがないことを確認する
      # within all('.board-list')[1]do
      #   expect(page).to have_no_link 'この掲示板についてはこちら'
      # end
      within '.more' do
        expect(page).to have_no_link '編集', href:edit_board_path(@board1)
      end
    end
    it 'ログインしていないと掲示板の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # ツイート1に「'編集'」へのリンクがないことを確認する
      visit board_path(@board1)
      within '.more' do
        expect(page).to have_no_link '編集', href:edit_board_path(@board1)
      end
      # ツイート2に「'編集'」へのリンクがないことを確認する
      visit board_path(@board2)
      within '.more' do
        expect(page).to have_no_link '編集', href:edit_board_path(@board1)
      end
    end
  end
end

RSpec.describe '掲示板削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @board1 = FactoryBot.create(:board, user: @user)
    @board2 = FactoryBot.create(:board)
  end
  context '掲示板削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した掲示板の削除ができる' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with:@user.email
      fill_in 'パスワード', with:@user.password
      find('input[name="commit"]').click
      expect(page).to have_current_path(root_path)
      # ツイート1に「'この掲示板についてはこちら'」へのリンクがあることを確認する
      within all('.board-list')[0]do
        expect(page).to have_link 'この掲示板についてはこちら'
      end
      # 掲示板詳細画面へ移動
      visit board_path(@board1)
      # 掲示板削除のリンクがあることを確認
      # expect(
      #   all('.more')[1].hover
      # ).to have_link 'destroy', href:board_path(@board1)
      within '.more' do
        expect(page).to have_link '削除'
      end
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        # all('.more')[0].find_link('削除',href: board_path(@board1)).click
        click_link '削除'
      }.to change{Board.count}.by(-1)
      # トップページには掲示板1の内容が存在しないことを確認する（タイトル）
      expect(page).to have_no_content("#{@board1.title}")
      # トップページには掲示板1の内容が存在しないことを確認する（説明文）
      expect(page).to have_no_content("#{@board1.description}")
    end
  end
  context '掲示板削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した掲示板の削除ができない' do
      # 掲示板1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(page).to have_current_path(root_path)
      # 掲示板2に「'削除'」へのリンクがないことを確認する
      visit board_path(@board2)
      within '.more' do
        expect(page).to have_no_link '削除'
      end
    end
    it 'ログインしていないと掲示板の削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # ツイート1に「'削除'」へのリンクがないことを確認する
      visit board_path(@board1)
      within '.more' do
        expect(page).to have_no_link '削除', href:board_path(@board1)
      end
      # ツイート2に「'削除'」へのリンクがないことを確認する
      visit board_path(@board2)
      within '.more' do
        expect(page).to have_no_link '削除', href:board_path(@board2)
      end
    end
  end
end

RSpec.describe '掲示板詳細', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @board1 = FactoryBot.create(:board, user: @user)
  end
  it 'ログインしたユーザーは掲示板詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
    visit new_user_session_path
    fill_in 'メールアドレス' , with:@user.email
    fill_in 'パスワード', with:@user.password
    find('input[name="commit"]').click
    expect(page).to have_current_path(root_path)
    # 掲示板1に「'この掲示板についてはこちら'」へのリンクがあることを確認する
      within all('.board-list')[0]do
        expect(page).to have_link 'この掲示板についてはこちら'
      end
    # 詳細ページに遷移する
    visit board_path(@board1)
    # 詳細ページに掲示板の内容が含まれている
    # expect(page).to have_selector ".content_post[style='background-image: url(#{@board.title});']"
    expect(page).to have_content("#{@board1.title}")
    expect(page).to have_content("#{@board1.description}")
    # コメント用のフォームが存在する
    expect(page).to have_selector('form')
  end
  it 'ログインしていない状態でツイート詳細ページに遷移できるもののコメント投稿欄が表示されない' do
    # トップページに移動する
    visit root_path
    # 掲示板に「'この掲示板についてはこちら'」へのリンクがあることを確認する
      within all('.board-list')[0]do
        expect(page).to have_link 'この掲示板についてはこちら'
      end
    # 詳細ページに遷移する
    visit board_path(@board1)
    # 詳細ページに掲示板の内容が含まれている
    expect(page).to have_content("#{@board1.title}")
    expect(page).to have_content("#{@board1.description}")
    # フォームが存在しないことを確認する
    expect(page).to have_no_selector('form') 
    # 「コメントの投稿には新規登録/ログインが必要です」が表示されていることを確認する
    expect(page).to have_content('コメントの投稿には新規登録/ログインが必要')
  end
end