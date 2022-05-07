class Space < ApplicationRecord
  validates :price, :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, :price, presence: :true

  belongs_to :warehouse
  belongs_to :product
end
