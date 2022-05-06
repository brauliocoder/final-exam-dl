class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships do |t|
      t.string :invitation_email
      t.string :unique_code
      t.boolean :is_active, default: true
      t.references :role, null: false, foreign_key: true
      t.references :user, foreign_key: true
      t.references :headquarter, null: false, foreign_key: true

      t.timestamps
    end
  end
end
