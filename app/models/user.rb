class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  after_create :init_profile

  has_one :profile
  has_many :headquarters
  has_many :warehouses
  has_many :memberships

  def is_allowed_headquarter_member(headquarter)
    membership = memberships.find_by_headquarter_id(headquarter.id)
    if membership && membership.role.full_admin?
      return true
    else
      return false
    end
  end

  def init_profile
    Profile.create(user_id: self.id)
  end
  
  
end
