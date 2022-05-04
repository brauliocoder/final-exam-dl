class Channel < ApplicationRecord
  belongs_to :headquarter

  has_many :memberships
  has_and_belongs_to_many :warehouses
end
