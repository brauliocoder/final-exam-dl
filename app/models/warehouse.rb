class Warehouse < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :channels
  
  has_many :spaces
  has_many :products, through: :spaces
end
