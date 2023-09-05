class LensesController < ApplicationController
  before_action :set_lens, only: [:show, :edit, :update, :destroy]

  # GET /lenses
  def index
    query = "#{params[:lens]} #{params[:city]} #{params[:camera]}".strip
    if query.empty?
      @lenses = Lens.all
    else
      @lenses = Lens.search_by_model_location_and_camera(query)
    end
  end

  # GET /lenses/1
  def show
    @lens = Lens.find(params[:id])
    @booking = Booking.new
  end

  # GET /lenses/new
  def new
    @lens = Lens.new
  end

  # GET /lenses/1/edit
  def edit; end

  # POST /lenses
  def create
    @lens = Lens.new(lens_params)
    @lens.save
    redirect_to lens_details_path(@lens), notice: 'Lens was successfully added.'
  end

  # PATCH/PUT /lens/1
  def update
    if @lens.update(lens_params)
      redirect_to @lens, notice: 'Lens was successfully added.'
    else
      render :edit
    end
  end

  # DELETE /lenses/1
  def destroy
    @lens.destroy
    redirect_to lens_url, notice: 'Lens was successfully deleted.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_lens
    @lens = Lens.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def lens_params
    params.require(:lens).permit(:name, :lens_type, :price, :location)
  end
end
