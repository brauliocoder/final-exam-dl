class Channel < ApplicationRecord
  validates :name, presence: :true

  belongs_to :headquarter

  has_and_belongs_to_many :memberships
  has_and_belongs_to_many :warehouses
end
