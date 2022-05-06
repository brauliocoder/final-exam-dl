class Headquarter < ApplicationRecord
  validates :brand, presence: :true

  belongs_to :user
  has_many :channels, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_and_belongs_to_many :warehouses
end
