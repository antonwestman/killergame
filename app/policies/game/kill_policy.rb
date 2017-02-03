module Game
  class KillPolicy < ApplicationPolicy
    def index?
      false
    end

    def create?
      user.targets.include? record.victim
    end

    def confirm?
      record.victim.user == user
    end

    def oppose?
      record.victim.user == user
    end
  end
end
