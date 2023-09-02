class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  def index
  end

  # GET /bookings/1
  def show; end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit; end

  # POST /bookings
  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      redirect_to booking_path(@booking), notice: 'Booking request was successfully send to the owner.'
    else
      render :new
    end
  end

  # PATCH/PUT /bookings/1
  def update
    @booking.update!(is_accepted: true)
    if @booking.save!
      redirect_to @booking, notice: 'Booking is validated by the owner.'
    else
      render :edit
    end
  end

  # DELETE /bookings/1
  def destroy
    @booking.destroy
    redirect_to booking_url, notice: 'Booking is denied by the owner.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_booking
    @booking = Booking.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def booking_params
    params.require(:booking).permit(:name, :type, :price, :location)
  end
end
