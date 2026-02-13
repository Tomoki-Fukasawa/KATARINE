class AddStateToFriendships < ActiveRecord::Migration[7.1]
  def change
    add_column :friendships, :state, :integer, null: false, default: 0
  end
end
