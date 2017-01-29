module Game
  class Round < ApplicationRecord
    has_many :players, dependent: :destroy
    has_many :missions, through: :players
    has_many :kills, dependent: :destroy

    def declare_winner!
      update! ongoing: false
    end
  end
end
