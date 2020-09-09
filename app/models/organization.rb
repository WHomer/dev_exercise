class Organization < ApplicationRecord
  validates :name, presence: true

  scope :filter_by_name, -> name { where("name LIKE ?", "%#{name&.downcase}%") }
end
