json.extract! order, :id, :is_completed, :membership_id, :channel_id, :created_at, :updated_at
json.url order_url(order, format: :json)
