class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.boolean :is_completed, default: false
      t.references :channel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
