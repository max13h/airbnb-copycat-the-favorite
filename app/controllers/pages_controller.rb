class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @type, @city, @camera = homepage_sections

    @lenses_type = Lens.where(lens_type: @type).shuffle
    @lenses_city = Lens.where(location: @city).shuffle
    @lenses_camera = Lens.where(camera: @camera).shuffle

    @lenses = []

    10.times do
      @lenses << Lens.all.sample
    end
  end

  def dashboard
    @bookings_on_future = Booking.where(user: current_user).where('start_date > ?', Date.today)
    @bookings_on_past = Booking.where(user: current_user).where('end_date < ?', Date.today)
    @future_bookings = @bookings_on_future.sort_by(&:start_date).first(2)
    @past_bookings = @bookings_on_past.sort_by(&:end_date).first(2)

    @lenses = Lens.where(user: current_user)
    @all_pending_booked_lenses = []

    @lenses.each do |lens|
      @all_pending_booked_lenses << lens.bookings.where(user: current_user).where(is_accepted: false).sort_by(&:start_date)

    end

    @all_pending_booked_lenses = @all_pending_booked_lenses.flatten.first(5)
  end

  private

  def homepage_sections
    type = ["Wide", "Normal", "Ultrawide", "Macro"].sample
    city = ["London", "Paris", "Madrid", "Berlin"].sample
    camera = Camera.all.sample

    return [type, city, camera]
  end
end
