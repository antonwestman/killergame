module Game
  class PlayerSerializer < ActiveModel::Serializer
    attributes :id, :username
    has_one :mission

    def username
      object.user.username
    end
  end
end
