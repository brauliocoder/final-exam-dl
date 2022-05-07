class Order < ApplicationRecord
  belongs_to :membership
  belongs_to :channel

  has_many :sales
  has_many :spaces, through: :sales
end
