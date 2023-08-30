class LensesController < ApplicationController
  before_action :set_lens, only: [:show, :edit, :update, :destroy]

  # GET /lenses
  def index
    @lenses = Lens.all
  end

  # GET /lenses/1
  def show; end

  # GET /lenses/new
  def new
    @lens = Lens.new
  end

  # GET /lenses/1/edit
  def edit; end

  # POST /lenses
  def create
    @lens = Lens.new(lens_params)

    if @lens.save
      redirect_to lens_path(@lens), notice: 'Lens was successfully added.'
    else
      render :new
    end
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
    params.require(:lens).permit(:name, :type, :price, :location)
  end
end
