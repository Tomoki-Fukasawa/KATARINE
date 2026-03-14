class CreateItemRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :item_requests do |t|
      t.references :item, null:false, foreign_key:true
      t.references :sender, null:false, foreign_key: {to_table: :users}
      t.references :receiver, foreign_key: {to_table: :users}
      t.integer :transfer, default:0, null:false

      t.timestamps
    end
    add_index :item_requests, [:item,:sender], unique: true
  end
end
