module Game
  class Player < ApplicationRecord
    belongs_to :user
    belongs_to :round
    has_one :mission, autosave: true, inverse_of: :player
  end
end
