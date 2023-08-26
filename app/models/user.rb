class User < ApplicationRecord
    has_many :lenses
    has_many :bookings
end
