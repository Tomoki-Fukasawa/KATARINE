require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'user登録に必要なすべての要素が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネーム を入力してください')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレス を入力してください")
      end
      it 'メールアドレスに＠を含んでいないと、登録できない' do
        @user.email = 'testcom'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレス は不正な値です')
      end
      it '重複したメールアドレスが存在する場合は、登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('メールアドレス はすでに存在します')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード を入力してください")
      end
      it 'passwordが6文字未満では登録できない' do
        @user.password = '111aa'
        @user.password_confirmation = '111aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード は6文字以上で入力してください')
      end
      it 'passwordは数字のみだと登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード には英字と数字の両方を含めて設定してください')
      end
      it 'passwordは英字のみだと登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード には英字と数字の両方を含めて設定してください')
      end
      it 'passwordは全角文字を含むと登録できない' do
        @user.password = 'ああああああ'
        @user.password_confirmation = 'ああああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード には英字と数字の両方を含めて設定してください')
      end
      it 'パスワードとパスワード（確認）が一致していないと、登録できない' do
        @user.password = '111aaa'
        @user.password_confirmation = '222aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認） と一致しません")
      end
      it 'お名前の姓(漢字)が空では登録できない' do
        @user.last_name_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('姓（漢字） を入力してください')
      end
      it 'お名前の名(漢字)が空では登録できない' do
        @user.first_name_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名（漢字） を入力してください')
      end
      it 'お名前の姓(漢字)で漢字・ひらがな・カタカナ以外が使われると、登録できない' do
        @user.last_name_kanji = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('姓（漢字） 全角文字を使用してください')
      end
      it 'お名前の名(漢字)で漢字・ひらがな・カタカナ以外が使われると、登録できない' do
        @user.first_name_kanji = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('名（漢字） 全角文字を使用してください')
      end
      it 'お名前の姓(カナ)が空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('姓（カナ） を入力してください')
      end
      it 'お名前の名(カナ)が空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名（カナ） を入力してください')
      end
      it 'お名前の姓(カナ)で漢字が使われると登録できない' do
        @user.last_name_kana = '一二三'
        @user.valid?
        expect(@user.errors.full_messages).to include('姓（カナ） 全角文字カタカナを使用してください')
      end
      it 'お名前の名(カナ)で漢字が使われると登録できない' do
        @user.first_name_kana = '一二三'
        @user.valid?
        expect(@user.errors.full_messages).to include('名（カナ） 全角文字カタカナを使用してください')
      end
      it '生年月日が空だと登録できない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日 を入力してください')
      end
      it 'imageが空では登録できない' do
        @user.image = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("画像 を入力してください")
      end
    end
  end
end
