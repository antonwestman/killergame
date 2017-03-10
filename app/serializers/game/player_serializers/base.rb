module Game
  module PlayerSerializers
    class Base < ActiveModel::Serializer
      attributes :id, :username

      def username
        object.username_or_email
      end
    end
  end
end
