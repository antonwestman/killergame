class UserPolicy < ApplicationPolicy
  def update?
    user == record || user.has_role?(:super_admin)
  end
end
