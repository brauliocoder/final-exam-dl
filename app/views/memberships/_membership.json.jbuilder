json.extract! membership, :id, :expiration, :autorenewal, :is_active, :role_id, :user_id, :channel_id, :created_at, :updated_at
json.url membership_url(membership, format: :json)
