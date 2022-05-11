class Warehouse < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :headquarters
  
  has_many :spaces
  has_many :products, through: :spaces
end
