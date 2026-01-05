require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Nickname を入力してください')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスに＠を含んでいないと、登録できない' do
        @user.email = 'testcom'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it '重複したメールアドレスが存在する場合は、登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが6文字未満では登録できない' do
        @user.password = '111aa'
        @user.password_confirmation = '111aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordは数字のみだと登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordは英字のみだと登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordは全角文字を含むと登録できない' do
        @user.password = 'ああああああ'
        @user.password_confirmation = 'ああああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'パスワードとパスワード（確認）が一致していないと、登録できない' do
        @user.password = '111aaa'
        @user.password_confirmation = '222aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'お名前の姓(漢字)が空では登録できない' do
        @user.last_name_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kanji を入力してください')
      end
      it 'お名前の名(漢字)が空では登録できない' do
        @user.first_name_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kanji を入力してください')
      end
      it 'お名前の姓(漢字)で漢字・ひらがな・カタカナ以外が使われると、登録できない' do
        @user.last_name_kanji = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kanji 全角文字を使用してください')
      end
      it 'お名前の名(漢字)で漢字・ひらがな・カタカナ以外が使われると、登録できない' do
        @user.first_name_kanji = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kanji 全角文字を使用してください')
      end
      it 'お名前の姓(カナ)が空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana を入力してください')
      end
      it 'お名前の名(カナ)が空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana を入力してください')
      end
      it 'お名前の姓(カナ)で漢字が使われると登録できない' do
        @user.last_name_kana = '一二三'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana 全角文字カタカナを使用してください')
      end
      it 'お名前の名(カナ)で漢字が使われると登録できない' do
        @user.first_name_kana = '一二三'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana 全角文字カタカナを使用してください')
      end
      it '生年月日が空だと登録できない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Birth day を入力してください')
      end
    end
  end
end
