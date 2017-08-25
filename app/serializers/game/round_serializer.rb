module Game
  class RoundSerializer < ActiveModel::Serializer
    attributes :id, :created_at, :alive_players_count, :dead_players_count, :ongoing, :name
    has_many :players, serializer: PlayerSerializers::Base

    delegate :alive_players_count, to: :object

    def dead_players_count
      object.players.dead.count
    end
  end
end
