module Game
  class MissionSerializer < ActiveModel::Serializer
    attributes :id, :target_user, :weapon, :place

    def target_user
      { username: object.target.username_or_email, id: object.target.id }
    end

    def weapon
      object.weapon.name
    end

    def place
      object.place.name
    end
  end
end
