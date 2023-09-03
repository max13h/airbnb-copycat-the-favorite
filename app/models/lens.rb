class Lens < ApplicationRecord
  belongs_to :user
  belongs_to :camera
  has_many :bookings

  has_one_attached :image

  validates :name, presence: true
  validates :lens_type, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }

  include PgSearch::Model

  pg_search_scope :search_by_model_location_and_camera,
  against: [ :name, :location ],
  associated_against: {
    camera: [ :model, :brand ]
  },
  using: {
    tsearch: { prefix: true }
  }
end
