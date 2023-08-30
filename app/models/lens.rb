class Lens < ApplicationRecord
  belongs_to :user
  belongs_to :camera
  has_many :bookings

  has_one_attached :image

  validates :name, presence: true
  validates :lens_type, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
