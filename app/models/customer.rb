class Customer < ApplicationRecord
  belongs_to :address

  scope :with_address, -> { includes(:address) }
  scope :search_by_name, ->(name) { where("name LIKE ?", "#{name}%") }
  scope :search_by_street, ->(street) { joins(:address).where("addresses.street LIKE ?", "#{street}%") }

  accepts_nested_attributes_for :address

  validates :name, presence: true
end
