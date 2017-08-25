module Game
  class Round < ApplicationRecord
    resourcify
    has_many :players, dependent: :destroy
    has_many :missions, through: :players
    has_many :kills, dependent: :destroy

    def finished?
      !ongoing
    end

    def declare_winner!
      update! ongoing: false
    end

    def alive_players_count
      players.alive.count
    end

    def update_game_state!
      declare_winner! if players.alive.count == 1
    end
  end
end
