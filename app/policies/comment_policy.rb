class CommentPolicy < ApplicationPolicy
  def destroy? 
    user.present? && ( record.user == user || user.admin?)
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
