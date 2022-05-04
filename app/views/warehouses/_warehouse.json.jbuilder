json.extract! warehouse, :id, :name, :description, :address, :is_active, :user_id, :created_at, :updated_at
json.url warehouse_url(warehouse, format: :json)
