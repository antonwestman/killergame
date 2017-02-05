class WeaponPolicy < ApplicationPolicy
  def create?
    user.has_role? :admin
  end
end
