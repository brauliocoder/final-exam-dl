class Product < ApplicationRecord
  validates :name, :brand, :sku, presence: :true

  has_one :space, dependent: :nullify
  has_many :warehouses, through: :spaces, dependent: :nullify
end
