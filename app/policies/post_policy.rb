class PostPolicy < ApplicationPolicy
  def edit?
    user_is_owner_or_admin?
  end

  def destroy?
    user_is_owner_or_admin?
  end

  def update?
    user_is_owner_or_admin?
  end

  private

  def user_is_owner_or_admin?
    user.present? && (record.user == user || user.admin?)
  end

  class Scope < ApplicationPolicy::Scope
    # You can customize this later if needed
    # def resolve
    #   scope.all
    # end
  end
end
