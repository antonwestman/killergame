module Game
  class KillsController < ApplicationController
    # GET /kills
    def index
      @kills = Kill.where(round_id: params.require(:round_id))

      render json: @kills
    end

    def create
      @kill = Kill.new(kill_params)

      if @kill.save
        render json: @kill, status: :created, location: @kill
      else
        render json: @kill.errors, status: :unprocessable_entity
      end
    end

    private

    def kill_params
      params.require(:kill).permit(:killer_id, :target_id, :round_id)
    end

  end
end
