module Game
  class Mission < ApplicationRecord
    belongs_to :player, class_name: Game::Player, inverse_of: :missions
    belongs_to :target, class_name: Game::Player
    belongs_to :place
    belongs_to :weapon
  end
end
