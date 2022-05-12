class Space < ApplicationRecord
  validates :price, :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, :product, presence: :true

  belongs_to :warehouse
  belongs_to :product

  has_many :sales, dependent: :destroy
  has_many :orders, through: :sales, dependent: :destroy

  def reduce_stock(reduction)
    self.stock -= reduction
    self.save
  end
  
  def return_stock(increment)
    self.stock += increment
    self.save
  end
end
