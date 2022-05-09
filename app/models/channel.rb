class Channel < ApplicationRecord
  validates :name, presence: :true

  belongs_to :headquarter
  has_and_belongs_to_many :memberships

  has_many :orders

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
  
  def add_product(order, product)
    duplicated_item = order.sales.find_by_space_id(product.id)
    if duplicated_item
      duplicated_item.quantity += 1
      duplicated_item.save
      
      return duplicated_item
    else
      return Sale.create(order_id: order.id, space_id: product.id, quantity: 1, price: product.price)
    end
  end

end
