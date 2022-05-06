class CreateJoinTableHeadquartersWarehouses < ActiveRecord::Migration[6.1]
  def change
    create_join_table :headquarters, :warehouses do |t|
      # t.index [:headquarter_id, :warehouse_id]
      # t.index [:warehouse_id, :headquarter_id]
    end
  end
end
