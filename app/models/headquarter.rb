class Headquarter < ApplicationRecord
  validates :brand, presence: :true

  belongs_to :user
  has_many :channels, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_and_belongs_to_many :warehouses

  def total_income
    total = 0
    
    self.channels.each do |channel|
      channel.orders.each do |order|
        total += order.total_order
      end
    end
    
    return total
  end
end
