module Game
  class KillPolicy < ApplicationPolicy
    def index?
      user.has_role? :admin
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
