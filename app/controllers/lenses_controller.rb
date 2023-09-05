class LensesController < ApplicationController
  before_action :set_lens, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  # GET /lenses
  def index
    if params[:query]
      q = "#{params[:query]} #{params[:lens_type]}"
      @lenses = Lens.filter_query_by_type_and_price(q).filter_by_max_price(params[:price])
      @query = params[:query]
      return @filters = "Lens type: #{params[:lens_type]}, max price: #{params[:price]}"
    end

    @query = "#{params[:lens]} #{params[:city]} #{params[:camera]}".strip
    @filters = false

    if @query.empty?
      @lenses = Lens.all
    else
      @lenses = Lens.search_by_model_location_and_camera(@query)
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

  # POST /lenses
  def create
    raise
    @lens = Lens.new(lens_params)
    @lens.user = current_user
    @lens.camera = Camera.last
    @lens.save!
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
    params.require(:lens).permit(:name, :lens_type, :price, :location, :image)
  end
end
