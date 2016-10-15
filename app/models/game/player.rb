module Game
  class Player < ApplicationRecord
    belongs_to :user
    belongs_to :round
    has_one :mission
    has_one :target, through: :mission
  end
end
