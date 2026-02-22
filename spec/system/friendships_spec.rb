require 'rails_helper'

RSpec.describe "Friendships", type: :system do
  before do
    driven_by(:rack_test)
    @userA=FactoryBot.create(:user)
    @userB=FactoryBot.create(:user)
  end

  context '友達募集' do
    it 'show画面で友達募集を行うと、index画面に表示される' do
      #サインイン
      visit new_user_session_path
      fill_in "メールアドレス", with: @userA.email
      fill_in "パスワード", with: @userA.password
      click_button "Log in"
      #user#show画面に移動
      visit user_path(@userA)
      #show画面の友達募集ボタンを押す
      click_on("友達を募集する")
      #Aがログアウトする
      # find_link("ログアウト", href: destroy_user_session_path, data: { turbo_method: :delete }).click
      click_link "ログアウト"
      #Bがログインする
      visit new_user_session_path
      fill_in "メールアドレス", with: @userB.email
      fill_in "パスワード", with: @userB.password
      click_button "Log in"      
      #root_pathにuserAの情報が表示される
      visit root_path
      expect(page).to have_link("この人の詳しい情報はこちら",href: user_path(@userA))
    end
    it 'show画面で友達募集を中止すると、index画面から表示されなくなる' do
      #サインイン
      visit new_user_session_path
      fill_in "メールアドレス", with: @userA.email
      fill_in "パスワード", with: @userA.password
      click_button "Log in"
      #user#show画面に移動
      visit user_path(@userA)
      #show画面の友達募集ボタンを押す
      click_on("友達を募集する")
      #show画面の友達募集中止ボタンを押す
      click_on("友達募集を停止する")
      #Aがログアウトする
      click_link "ログアウト"
      #Bがログインする
      visit new_user_session_path
      fill_in "メールアドレス", with: @userB.email
      fill_in "パスワード", with: @userB.password
      click_button "Log in"            
      #root_pathからuserAの情報が表示されない
      visit root_path
      expect(page).not_to have_link("この人の詳しい情報はこちら",href: user_path(@userA))
    end
  end
  context 'BがAに対して友達登録を申請する' do
    before do
      # Aが募集状態になる操作をする
      visit new_user_session_path
      fill_in "メールアドレス", with: @userA.email
      fill_in "パスワード", with: @userA.password
      click_button "Log in"

      visit user_path(@userA)
      click_on("友達を募集する")
      click_link "ログアウト"
    end    
    it 'BがAのshow画面に移動すると、Aのshow画面で友達申請ができる' do
      #サインイン
      visit new_user_session_path
      fill_in "メールアドレス", with: @userB.email
      fill_in "パスワード", with: @userB.password
      click_button "Log in"
      # トップページに遷移していることを確認する
      expect(page).to have_current_path(root_path)
      #root_pathでAの情報を見つけ、Aのshow画面に移動する
      find_link('この人の詳しい情報はこちら', href: user_path(@userA)).click
      #Aのshow画面に移動し、友達申請ボタンを押す,ログアウト
      expect(page).to have_current_path(user_path(@userA))
      # find_link("友達申請をする", href: friendships_path(friend_id:@userA)).click
      click_button "友達申請をする"
      #userBの友達一覧画面に移動,承認中が表示される
      visit friends_user_path(@userB)
      expect(page).to have_content('申請中です。お待ちください')
      #userBがログアウト
      # sign_out(@userB)
      click_link "ログアウト"
      #userAがサインイン
      visit new_user_session_path
      fill_in "メールアドレス", with: @userA.email
      fill_in "パスワード", with: @userA.password
      click_button "Log in"
      #userAの友達一覧画面に移動,userBが表示される
      visit friends_user_path(@userA)
      expect(page).to have_content('この人と友達になりますか？')
    end
    it '友達登録申請後、登録が承認される' do
      #Bがサインイン
      visit new_user_session_path
      fill_in "メールアドレス", with: @userB.email
      fill_in "パスワード", with: @userB.password
      click_button "Log in"
      # トップページに遷移していることを確認する
      expect(page).to have_current_path(root_path)
      #root_pathでAの情報を見つけ、Aのshow画面に移動する
      find_link('この人の詳しい情報はこちら', href: user_path(@userA)).click
      #Aのshow画面に移動し、友達申請ボタンを押す
      expect(page).to have_current_path(user_path(@userA))
      # find_link("友達申請をする", href: friendships_path(friend_id:@userA)).click
      click_button "友達申請をする"
      #userBの友達一覧画面に移動,承認中が表示される
      visit friends_user_path(@userB)
      expect(page).to have_content('申請中です。お待ちください')
      #userBがログアウト
      # sign_out(@userB)
      click_link "ログアウト"
      #Aがサインイン
      visit new_user_session_path
      fill_in "メールアドレス", with: @userA.email
      fill_in "パスワード", with: @userA.password
      click_button "Log in"
      #userAの友達一覧画面に移動
      visit friends_user_path(@userA)
      #友達申請をしたBの名前を見つける。
      expect(page).to have_content(@userB.nickname)
      #Bの友達申請を承認する
      # friendshipX=@userA.friendships.find_by(friend_id: @userB.id)
      # puts Friendship.all.inspect
      # find_link('この人と友達になりますか？', href: friendship_path(give_user)).click
      click_button "この人と友達になりますか？"
      #Bが友達一覧に表示される
      within("#friend_permitted_users") do
        expect(page).to have_content(@userB.nickname)
      end
    end
    it '登録が拒否される' do
      #Bがサインイン
      visit new_user_session_path
      fill_in "メールアドレス", with: @userB.email
      fill_in "パスワード", with: @userB.password
      click_button "Log in"
      # トップページに遷移していることを確認する
      expect(page).to have_current_path(root_path)
      #root_pathでAの情報を見つけ、Aのshow画面に移動する
      find_link('この人の詳しい情報はこちら', href: user_path(@userA)).click
      #Aのshow画面に移動し、友達申請ボタンを押す
      # expect(page).to have_current_path(user_path(@userA))
      # find_link("友達申請をする", href: friendships_path(friend_id:@userA)).click
      click_button "友達申請をする"
      #userBの友達一覧画面に移動,承認中が表示される
      visit friends_user_path(@userB)
      expect(page).to have_content('申請中です。お待ちください')
      #userBがログアウト
      # sign_out(@userB)
      click_link "ログアウト"
      #Aがサインイン
      visit new_user_session_path
      fill_in "メールアドレス", with: @userA.email
      fill_in "パスワード", with: @userA.password
      click_button "Log in"
      #userAの友達一覧画面に移動
      visit friends_user_path(@userA)
      #友達申請をしたBの名前を見つける。
      expect(page).to have_content(@userB.nickname)
      #Bの友達申請を拒否する
      # friendshipX=@userA.friendships.find_by(friend_id: @userB.id)
      # puts Friendship.all.inspect
      # find_link('この人を拒否しますか？', href: reject_friendship_path(give_user)).click
      click_button "この人を拒否しますか？"
      #Bが友達拒否一覧に表示される
      within("#rejected_users") do
        expect(page).to have_content(@userB.nickname)
      end
    end
  end

end
