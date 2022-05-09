class Channel < ApplicationRecord
  validates :name, presence: :true

  belongs_to :headquarter
  has_and_belongs_to_many :memberships

  def search_membership(user_id)
    memberships.find_by_user_id(user_id)
  end

  def search_product(search_name)
    whs = headquarter.warehouses.pluck(:id)
    query = Space.where(warehouse_id: whs).joins(:product).where("products.name ILIKE ?", "%#{search_name}%")

    return query
  end

  # select product from a warehouse
  def find_product(product_id)
    whs = headquarter.warehouses.pluck(:id)
    product = Space.where(warehouse_id: whs).find_by_id(product_id)    
    return product
  end
  
end
