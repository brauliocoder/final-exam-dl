class Order < ApplicationRecord
  belongs_to :membership
  belongs_to :channel
end
