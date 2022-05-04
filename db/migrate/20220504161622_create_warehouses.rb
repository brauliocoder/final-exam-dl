class CreateWarehouses < ActiveRecord::Migration[6.1]
  def change
    create_table :warehouses do |t|
      t.string :name
      t.text :description
      t.string :address
      t.boolean :is_active
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
