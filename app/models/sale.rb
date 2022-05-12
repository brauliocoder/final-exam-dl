class Sale < ApplicationRecord
  validates :quantity, :price, presence: :true

  belongs_to :order
  belongs_to :space

  def product_name
    return self.space.product.name
  end

end
