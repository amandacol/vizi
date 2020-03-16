class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where.not(state: 'paid').where(user: user)
    end
  end

  def index?
    true
  end
  def create?
    true
  end

  def new?
    true
  end
  def destroy?
    true
  end
end
