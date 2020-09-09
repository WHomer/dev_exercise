class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  has_many :memberships
  has_many :organizations, through: :memberships
end
