module Game
  class Round < ApplicationRecord
    has_many :players, dependent: :destroy
    has_many :missions, through: :players

    validates :players, length: { minimum: 2 }

    validates_associated :players
  end
end
