class Sale < ApplicationRecord
  belongs_to :order
  belongs_to :space
end
