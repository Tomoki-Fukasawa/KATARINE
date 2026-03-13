class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :item_name,           null: false
      t.text :item_script,              null: false

      t.integer :category_id,          null: false
      t.integer :item_state_id ,   null: false

      t.integer :prefecture_id ,  null: false
      t.integer :deliver_day_id ,   null: false
      t.references :user,           null: false, foreign_key:true

      t.timestamps
    end
  end
end
