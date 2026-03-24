require 'rails_helper'

RSpec.describe "Mypages", type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)

    @friendship=FactoryBot.create(
                  :friendship,
                  user: @user1,
                  friend: @user2,
                  state: :accepted
                )

    @item=FactoryBot.create(
            :item,
            user: @user1,
            reservation: :available
          )
    @item2=FactoryBot.create(
            :item,
            item_name: "品物２",
            user: @user2,
            reservation: :available
          )
    @item_request=FactoryBot.create(
                    :item_request,
                    sender: @user2,
                    item: @item,
                    transfer: :waiting
                  )
  end

  context "ログインしている場合" do
    it "user1が出品したitemの情報が表示されるか" do
      sign_in(@user1)

      visit mypage_path

      expect(page).to have_content(@item.item_name)
      
    end
    it "user2が申請したitem_requestの情報が表示されるか" do
      sign_in(@user2)

      visit mypage_path

      expect(page).to have_content(@item_request.item.item_name)
    end
    it "他者のitem,item_requestは表示されない" do
      sign_in(@user1)

      visit mypage_path

      expect(page).to have_no_content(@item2.item_name)
    end
  end
  context "ログインしていない場合" do
    it "いずれの情報も表示されず、ログイン画面に移動する" do
      visit mypage_path

      expect(page).to have_current_path(new_user_session_path)
    end
  end 
end
