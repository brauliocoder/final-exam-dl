class Membership < ApplicationRecord
  validates :invitation_email, presence: :true
  validates :invitation_email, uniqueness: { scope: :headquarter }

  after_create :asign_unique_code

  belongs_to :role
  belongs_to :user, optional: true
  belongs_to :headquarter
  
  has_and_belongs_to_many :channels

  def asign_unique_code
    self.unique_code = Digest::SHA256.hexdigest "#{rand(1000..9999)}"
    self.save
  end
end
