module Game
  class KillsController < ApplicationController
    # GET /kills
    def index
      @kills = Kill.where(round_id: params.require(:round_id))

      render json: @kills
    end
  end
end
