class PlacePolicy < ApplicationPolicy
  def create?
    user.has_role? :admin
  end
end
