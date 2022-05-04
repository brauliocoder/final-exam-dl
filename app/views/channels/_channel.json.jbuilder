json.extract! channel, :id, :name, :address, :is_active, :headquarter_id, :created_at, :updated_at
json.url channel_url(channel, format: :json)
