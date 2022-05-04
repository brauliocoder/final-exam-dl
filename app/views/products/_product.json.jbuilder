json.extract! product, :id, :name, :brand, :SKU, :created_at, :updated_at
json.url product_url(product, format: :json)
