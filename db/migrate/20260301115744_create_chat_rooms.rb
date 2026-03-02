class CreateChatRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_rooms do |t|
      t.references :user1, null: false, foreign_key: { to_table: :users}
      t.references :user2, null: false, foreign_key: { to_table: :users}

      t.timestamps
    end

    add_index :chat_rooms, [:user1_id, :user2_id], unique: true
  end
end
