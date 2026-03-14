class CreateItemStates < ActiveRecord::Migration[7.1]
  def change
    create_table :item_states do |t|

      t.timestamps
    end
  end
end
