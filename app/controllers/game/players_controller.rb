module Game
  class PlayersController < ApplicationController
    before_action :set_player, only: [:show]

    # GET /game/players
    def index
      @players = Player.where(player_params.permit(:round_id))
                       .paginate(page: params[:page])
      authorize Player

      render json: @players, each_serializer: PlayerSerializers::Base
    end

    # GET /game/players/1
    def show
      authorize @player

      render json: @player, serializer: PlayerSerializers::Base
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def player_params
      params.permit(:round_id)
    end
  end
end
