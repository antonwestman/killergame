module Game
  class PlayerSerializer < ActiveModel::Serializer
    attributes :id, :username, :status
    has_one :mission, serializer: MissionSerializer

    def username
      object.player_name || object.user.username
    end
  end
end
