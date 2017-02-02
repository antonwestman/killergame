module Game
  class KillPolicy < ApplicationPolicy
    def create?
      user.targets.include? record.victim
    end

    def accept?
      record.victim == user
    end

    def oppose?
      record.victim == user
    end
  end
end
