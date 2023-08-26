class Lens < ApplicationRecord
  belongs_to :user
  belongs_to :camera
  has_many :bookings
end
