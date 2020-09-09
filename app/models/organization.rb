class Organization < ApplicationRecord
  validates :name, presence: true

  has_many :memberships
  has_many :users, through: :memberships

  scope :filter_by_name, -> name { where("name LIKE ?", "%#{name&.downcase}%") }
end
