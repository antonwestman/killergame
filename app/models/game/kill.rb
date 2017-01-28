module Game
  class Kill < ApplicationRecord
    belongs_to :killer, class_name: Game::Player
    belongs_to :victim, class_name: Game::Player
    belongs_to :round

    validates :killer,
              :victim,
              :round, presence: true
  end
end
