class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    return true
  end
  def new?
    record
  end

  def create?
    new?
  end
end
