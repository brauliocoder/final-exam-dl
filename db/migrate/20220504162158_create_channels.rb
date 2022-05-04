class CreateChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :channels do |t|
      t.string :name
      t.string :address
      t.boolean :is_active
      t.references :headquarter, null: false, foreign_key: true

      t.timestamps
    end
  end
end