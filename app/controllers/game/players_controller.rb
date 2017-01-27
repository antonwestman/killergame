module Game
  class PlayersController < ApplicationController
    before_action :set_player, only: [:show]

    # GET /game/players
    def index
      @players = Game::Player.where(params.permit(:round_id))

      render json: @players
    end

    # GET /game/players/1
    def show
      render json: @player
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Game::Player.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def player_params
      params.require(:player).permit(:round_id)
    end
  end
end
