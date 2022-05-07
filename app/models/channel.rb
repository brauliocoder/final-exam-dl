class Channel < ApplicationRecord
  validates :name, presence: :true

  belongs_to :headquarter
  has_and_belongs_to_many :memberships

  def search_membership(user_id)
    memberships.find_by_user_id(user_id)
  end

  def search_product(search_name)
    whs = headquarter.warehouses.pluck(:id)
    q = Space.where(warehouse_id: whs).joins(:product).where("products.name ILIKE ?", "%#{search_name}%")

    return q
  end
end
