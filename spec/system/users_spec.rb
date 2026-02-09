require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit unauthenticated_root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_nickname', with: 'testuser'
      fill_in 'user_email', with: Faker::Internet.unique.email
      fill_in 'user_password', with: 'password123'
      fill_in 'user_password_confirmation', with: 'password123'

      fill_in 'user_last_name_kanji', with: '山田'
      fill_in 'user_first_name_kanji', with: '太郎'
      fill_in 'user_last_name_kana', with: 'ヤマダ'
      fill_in 'user_first_name_kana', with: 'タロウ'
      find('#user_birth_day').set(Date.new(1995, 5, 20))
      attach_file 'user_image', Rails.root.join('spec/fixtures/files/test_image.png')
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        click_button 'Sign up'
      }.to change(User.count).by(1)
    
      # トップページへ遷移することを確認する
      # expect(current_path).to eq authenticated_root_path
      expect(page).to have_current_path(authenticated_root_path)
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do    
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # # トップページに移動する
      visit unauthenticated_root_path
      # # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'user_nickname', with: ''
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      fill_in 'user_password_confirmation', with: ''

      fill_in 'user_last_name_kanji', with: ''
      fill_in 'user_first_name_kanji', with: ''
      fill_in 'user_last_name_kana', with: ''
      fill_in 'user_first_name_kana', with: ''

      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        click_button 'Sign up'
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      # expect(page).to have_current_path(new_user_registration_path)
      expect(page).to have_content('Sign up')
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit unauthenticated_root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: 'password123'
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq authenticated_root_path
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      # expect(page).to have_no_content('新規登録')
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # # トップページに移動する
      visit unauthenticated_root_path
      # # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'user_email', with: ''
      fill_in 'user_password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(page).to have_content('新規登録')
      expect(page).to have_content('Log in')
    end
  end
end