class Order < ApplicationRecord
  belongs_to :channel

  has_many :sales
  has_many :spaces, through: :sales

  def total_order
    return self.sales.sum(:price)
  end
  
  def total_products
    return self.sales.count
  end

  def total_units
    return self.sales.sum(:quantity)
  end

end
