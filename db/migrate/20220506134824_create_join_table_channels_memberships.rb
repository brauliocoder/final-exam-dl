class CreateJoinTableChannelsMemberships < ActiveRecord::Migration[6.1]
  def change
    create_join_table :channels, :memberships do |t|
      # t.index [:channel_id, :membership_id]
      # t.index [:membership_id, :channel_id]
    end
  end
end
