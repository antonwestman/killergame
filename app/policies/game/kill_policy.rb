module Game
  class KillPolicy < ApplicationPolicy
    def index?
      user.has_role?(:super_admin)
    end

    def create?
      user.players
          .include?(record.killer) && record.killer
                                            .target == record.victim
    end

    def confirm?
      record.victim.user == user
    end

    def oppose?
      record.victim.user == user
    end
  end
end
