class Booking < ApplicationRecord
  belongs_to :lens
  belongs_to :user
end
