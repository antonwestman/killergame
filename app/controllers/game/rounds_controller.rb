class Game::RoundsController < ApplicationController
  before_action :set_game_round, only: [:show, :update, :destroy]

  # GET /game/rounds
  def index
    @game_rounds = Game::Round.all

    render json: @game_rounds
  end

  # GET /game/rounds/1
  def show
    render json: @game_round
  end

  # POST /game/rounds
  def create
    users = User.where(id: params[:user_ids])

    @game_round = CreateGameRound.call(users: users)

    if @game_round.persisted?
      render json: @game_round, status: :created, location: @game_round
    else
      render json: @game_round.errors, status: :unprocessable_entity
    end
  end

  # DELETE /game/rounds/1
  def destroy
    @game_round.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_round
      @game_round = Game::Round.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def game_round_params
      params.fetch(:game_round, {})
    end
end
