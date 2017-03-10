module Game
  class RoundsController < ApplicationController
    before_action :set_game_round, only: [:show, :update, :destroy, :me]

    # GET /game/rounds
    def index
      @game_rounds = Round.paginate(page: params[:page])
      authorize @game_rounds

      render json: @game_rounds
    end

    # GET /game/rounds/1
    def show
      authorize @game_round
      render json: @game_round
    end

    # POST /game/rounds
    def create
      authorize Round
      users = User.where(id: game_round_params.require(:user_ids))

      @game_round = CreateGameRound.call(users: users, admin: current_user)

      if @game_round.persisted?
        render json: @game_round, status: :created
      else
        render json: @game_round.errors, status: :unprocessable_entity
      end
    end

    def me
      authorize @game_round
      player = current_user.players.where(round: @game_round).first
      render json: player, serializer: PlayerSerializers::Me
    end

    # DELETE /game/rounds/1
    def destroy
      authorize @game_round
      @game_round.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_game_round
      @game_round = Game::Round.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def game_round_params
      ids = params[:user_ids]
      params[:user_ids] = JSON.parse ids if ids.is_a? String
      params.permit(user_ids: [])
    end
  end
end
