class Address < ApplicationRecord
  has_many :customers

  validates :street, :city, :zip_code, presence: true
end
