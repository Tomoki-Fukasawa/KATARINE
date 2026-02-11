class AddFriendWantToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :friend_want, :boolean
  end
end
