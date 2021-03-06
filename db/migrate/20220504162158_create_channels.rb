class CreateChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :channels do |t|
      t.string :name
      t.text :description
      t.boolean :is_active, default: true
      t.references :headquarter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
