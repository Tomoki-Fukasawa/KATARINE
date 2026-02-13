class AddFriendWantToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :friend_want, :boolean, default: false, null: false
  end
end
