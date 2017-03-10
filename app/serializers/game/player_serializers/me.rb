module Game
  module PlayerSerializers
    class Me < Base
      attributes :status
      has_one :mission, serializer: MissionSerializer
    end
  end
end
