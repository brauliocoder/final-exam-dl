class Membership < ApplicationRecord
  belongs_to :role
  belongs_to :user
  belongs_to :headquarter
  has_and_belongs_to_many :channels
end
