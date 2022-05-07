class Product < ApplicationRecord
  has_one :space
  has_many :warehouses, through: :spaces
end
