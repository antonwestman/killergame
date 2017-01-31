class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /game/users
  def index
    @q = User.ransack(params[:q])
    @users = @q.result.paginate(page: params[:page])
    render json: @users
  end

  # GET /game/users/1
  def show
    render json: @user
  end

  # PATCH/PUT /game/users/1
  def update
    authorize @user

    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /game/users/1
  def destroy
    authorize @user

    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :email)
  end
end
