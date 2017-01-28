module Game
  class RoundSerializer < ActiveModel::Serializer
    attributes :id, :created_at, :alive_players_count, :dead_players_count, :ongoing
    has_many :players

    def alive_players_count
      object.players.alive.count
    end

    def dead_players_count
      object.players.dead.count
    end
  end
end
