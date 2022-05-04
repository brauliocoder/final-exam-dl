class CreateHeadquarters < ActiveRecord::Migration[6.1]
  def change
    create_table :headquarters do |t|
      t.string :brand
      t.boolean :is_active
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
