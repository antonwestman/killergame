class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :update, :destroy]

  # GET /places
  def index
    @q = Place.ransack(params[:q])
    @places = @q.result(distinct: true).paginate(page: params[:page])

    render json: @places
  end

  # GET /places/1
  def show
    render json: @place
  end

  # POST /places
  def create
    @place = Place.new(place_params)

    authorize @place

    if @place.save
      render json: @place, status: :created, location: @place
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /places/1
  def update
    authorize @place

    if @place.update(place_params)
      render json: @place
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  # DELETE /places/1
  def destroy
    authorize @place
    @place.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_place
    @place = Place.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def place_params
    params.require(:place).permit(:name)
  end
end
