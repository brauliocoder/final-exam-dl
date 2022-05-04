class Product < ApplicationRecord
  has_many :spaces
  has_many :warehouses, through: :spaces
end
