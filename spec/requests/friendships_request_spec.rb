require 'rails_helper'

RSpec.describe "Friendships", type: :request do
  before do
    @userA=FactoryBot.create(:user)
    @userB=FactoryBot.create(:user)
    @friendship = FactoryBot.create(:friendship)
  end

  context '友達募集' do
    it 'show画面で友達募集を行うと、index画面に表示される' do
      #サインイン
      sign_in(@userA)
      #user#show画面に移動
      get user_path(@userA)
      #show画面の友達募集ボタンを押す
      click_on("友達を募集する")
      #root_pathにuserAの情報が表示される
      expect(root_path).to include('member')
    end
    it 'show画面で友達募集を中止すると、index画面から表示されなくなる' do
      #サインイン
      sign_in(@userA)
      #user#show画面に移動
      get user_path(@userA)
      #show画面の友達募集ボタンを押す
      click_on("友達を募集する")
      #show画面の友達募集中止ボタンを押す
      click_on("友達募集を停止する")
      #root_pathからuserAの情報が表示されない
      expect(root_path).not_to include('member')
    end
  end
  context 'BがAに対して友達登録を申請する' do
    it 'BがAのshow画面に移動すると、Aのshow画面で友達申請ができる' do
      #サインイン
      sign_in(@userB)
      # トップページに遷移していることを確認する
      expect(page).to have_current_path(root_path)
      #root_pathでAの情報を見つけ、Aのshow画面に移動する
      find_link('この人の詳しい情報はこちら', href: user_path(@userA)).click
      #Aのshow画面に移動し、友達申請ボタンを押す,ログアウト
      expect(page).to have_current_path(user_path(@userA))
      find_link("友達申請をする", href: friendships_path(friend_id:@userA)).click
      #userBの友達一覧画面に移動,承認中が表示される
      get friends_user_path(@userB)
      expect(friends_user_path(@userB)).to include('申請中です。お待ちください')
      #userBがログアウト
      sign_out(@userB)
      #Aがサインインする
      sign_in(@userA)
      #userAの友達一覧画面に移動,userBが表示される
      get friends_user_path(@userA)
      expect(friends_user_path(@userA)).to include('この人と友達になりますか？')
    end
    it '友達登録申請後、登録が承認される' do
      #Aがサインイン
      sign_in(@userA)
      #userAの友達一覧画面に移動
      get friends_user_path(@userA)
      #友達申請をしたBの名前を見つける。
      expect(friends_user_path(@userA)).to include('give_user.user.nickname')
      #Bの友達申請を承認する
      find_link('この人と友達になりますか？', href: friendship_path(friend_id: given_user.@userA)).click
      #Bが友達一覧に表示される
      expect(friends_user_path(@userA)).to include(@user.nickname)
    end
    it '登録が拒否される'
      #Aがサインイン
      sign_in(@userA)
      #userAの友達一覧画面に移動
      get friends_user_path(@userA)
      #友達申請をしたBの名前を見つける。
      expect(friends_user_path(@userA)).to include('give_user.user.nickname')
      #Bの友達申請を承認する
      find_link('この人を拒否しますか？', href: reject_friendship_path(friend_id: given_user.@userA)).click
      #Bが友達拒否一覧に表示される
      expect(friends_user_path(@userA)).to include(@user.nickname)
    end
  end

end
