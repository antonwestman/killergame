module Game
  class MissionSerializer < ActiveModel::Serializer
    attributes :id, :target, :weapon, :place

    def target
      object.target.user.username
    end

    def weapon
      object.weapon.name
    end

    def place
      object.place.name
    end

  end
end