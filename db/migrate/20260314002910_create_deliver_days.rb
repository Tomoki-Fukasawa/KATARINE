class CreateDeliverDays < ActiveRecord::Migration[7.1]
  def change
    create_table :deliver_days do |t|

      t.timestamps
    end
  end
end
