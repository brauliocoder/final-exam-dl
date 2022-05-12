class Channel < ApplicationRecord
  validates :name, presence: :true

  belongs_to :headquarter
  has_and_belongs_to_many :memberships

  has_many :orders, dependent: :destroy

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
      if product.stock > 0
        q = duplicated_item.quantity += 1
        duplicated_item.price = product.price * q
        duplicated_item.save
  
        duplicated_item.space.reduce_stock(1)
        
        return duplicated_item
      end
      
    else 
      if product.stock > 0
        sale = Sale.create(order_id: order.id, space_id: product.id, quantity: 1, price: product.price)
        sale.space.reduce_stock(1)
  
        return sale
      end
    end
  end

  def remove_product(order, product, remove_all = false)
    item = order.sales.find_by_space_id(product.id)
    if item.quantity > 1 && !remove_all
      item.quantity -= 1
      item.save

      item.space.return_stock(1)
    else
      item.space.return_stock(item.quantity)
      item.destroy
    end
  end

end
