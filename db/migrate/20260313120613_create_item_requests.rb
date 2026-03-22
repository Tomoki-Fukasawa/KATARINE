class CreateItemRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :item_requests do |t|
      t.references :item, null:false, foreign_key:true
      t.references :sender, null:false, foreign_key: {to_table: :users}
      t.integer :transfer, default:0, null:false

      t.timestamps
    end
    add_index :item_requests, [:item_id,:sender_id], unique: true
    add_index :item_requests, [:item_id], unique: true, where: "transfer = 1", name: "index_item_request_item_transfer_accepted"
  end
end
