module Game
  class KillsController < ApplicationController
    before_action :set_kill, only: [:accept, :oppose]

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

    def accept
      current_user = @kill.victim # until auth is in place
      current_user.accept_kill!(@kill)
    end

    def oppose
      current_user = @kill.victim # until auth is in place
      current_user.oppose_kill!(@kill)
    end

    private

    def set_kill
      @kill = Kill.find(params[:id])
    end

    def kill_params
      params.require(:kill).permit(:killer_id, :target_id, :round_id)
    end
  end
end
