class Headquarter < ApplicationRecord
  belongs_to :user
  has_many :channels, dependent: :destroy
end
