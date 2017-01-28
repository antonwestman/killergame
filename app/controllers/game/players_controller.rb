module Game
  class PlayersController < ApplicationController
    before_action :set_player, only: [:show, :kill, :accept_kill, :oppose_kill]

    # GET /game/players
    def index
      @players = Player.where(params.permit(:round_id))

      render json: @players
    end

    # GET /game/players/1
    def show
      render json: @player
    end

    def kill
      # TMP until auth
      killer = Player.find(params[:killer_id])

      @player.mark_as_killed!(killer: killer)
      head :ok
    end

    def accept_kill
      @player.accept_kill!
      head :ok
    end

    def oppose_kill
      @player.oppose_kill!
      head :ok
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
