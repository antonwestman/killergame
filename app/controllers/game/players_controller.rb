module Game
  class PlayersController < ApplicationController
    before_action :set_player, only: [:show, :update, :destroy]

    # GET /game/players
    def index
      @players = Game::Player.all

      render json: @players
    end

    # GET /game/players/1
    def show
      render json: @player
    end

    # POST /game/players
    def create
      @player = Game::Player.new(player_params)

      if @player.save
        render json: @player, status: :created, location: @player
      else
        render json: @player.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /game/players/1
    def update
      if @player.update(player_params)
        render json: @player
      else
        render json: @player.errors, status: :unprocessable_entity
      end
    end

    # DELETE /game/players/1
    def destroy
      @player.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_player
        @player = Game::Player.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def player_params
        params.fetch(:player, {})
      end
  end
end