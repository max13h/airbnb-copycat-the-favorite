class Lens < ApplicationRecord
  belongs_to :user
  belongs_to :camera
  has_many :bookings
  validates :name, presence: true
  validates :type, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
