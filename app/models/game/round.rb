module Game
  class Round < ApplicationRecord
    has_many :players, dependent: :destroy
    has_many :missions, through: :players

    validates_associated :players
  end
end
