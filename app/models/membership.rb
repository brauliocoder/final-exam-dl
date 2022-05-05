class Membership < ApplicationRecord
  belongs_to :role
  belongs_to :user
  belongs_to :headquarter
  belongs_to :channel
end
