class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships do |t|
      t.datetime :expiration
      t.boolean :autorenewal
      t.boolean :is_active, default: true
      t.references :role, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :headquarter, null: false, foreign_key: true
      t.references :channel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
