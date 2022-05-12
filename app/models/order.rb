class Order < ApplicationRecord
  before_destroy :restore_stocks

  belongs_to :channel

  has_many :sales, dependent: :destroy
  has_many :spaces, through: :sales, dependent: :nullify

  def total_order
    return self.sales.sum(:price)
  end
  
  def total_products
    return self.sales.count
  end

  def total_units
    return self.sales.sum(:quantity)
  end

  def restore_stocks
    sales.each do |sale|
      sale.space.return_stock(sale.quantity)
    end
  end
  
  
end
