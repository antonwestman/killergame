module Game
  class RoundPolicy < ApplicationPolicy
    def create?
      true
    end

    def me?
      user.players.map(&:round).include? record
    end

    def destroy?
      user.has_role? :admin, record
    end
  end
end
