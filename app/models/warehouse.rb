class Warehouse < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :headquarters
  
  has_many :spaces, dependent: :destroy
  has_many :products, through: :spaces, dependent: :destroy
end
