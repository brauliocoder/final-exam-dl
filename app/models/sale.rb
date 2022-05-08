class Sale < ApplicationRecord
  validates :quantity, :price, presence: :true

  belongs_to :order
  belongs_to :space
end
