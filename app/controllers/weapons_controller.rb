class WeaponsController < ApplicationController
  before_action :set_weapon, only: %i[update destroy]

  # GET /weapons
  def index
    @q = Weapon.ransack(params[:q])
    @weapons = @q.result(distinct: true).paginate(page: params[:page])

    render json: @weapons
  end

  # POST /weapons
  def create
    @weapon = Weapon.new(weapon_params)
    authorize @weapon

    if @weapon.save
      render json: @weapon, status: :created
    else
      render json: @weapon.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /weapons/1
  def update
    authorize @weapon

    if @weapon.update(weapon_params)
      render json: @weapon
    else
      render json: @weapon.errors, status: :unprocessable_entity
    end
  end

  # DELETE /weapons/1
  def destroy
    authorize @weapon

    @weapon.destroy
    head :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_weapon
    @weapon = Weapon.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def weapon_params
    params.permit(:name)
  end
end
