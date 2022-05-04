class CreateJoinTableChannelsWarehouses < ActiveRecord::Migration[6.1]
  def change
    create_join_table :channels, :warehouses do |t|
      # t.index [:channel_id, :warehouse_id]
      # t.index [:warehouse_id, :channel_id]
    end
  end
end
