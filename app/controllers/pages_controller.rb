class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
    @bookings_on_future = Booking.where(user: current_user).where('start_date > ?', Date.today)
    @bookings_on_past = Booking.where(user: current_user).where('end_date < ?', Date.today)
    @future_bookings = @bookings_on_future.sort_by(&:start_date).first(3)
    @past_bookings = @bookings_on_past.sort_by(&:end_date).first(2)

    @all_pending_booked_lenses = Booking.where(user: current_user).where(is_accepted: false).sort_by(&:start_date).first(5)

  end
end
