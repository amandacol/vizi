class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # scope = Item
      paid_orders = Order.where(state: 'paid').pluck(:id)
      no_go_items = Item.includes(:orders).where(transaction_type: "Sale", orders: { id: paid_orders }).pluck(:id)
      scope.where.not(id: no_go_items)
    end
  end

  def new?
    return true
  end

  def edit?
    return true
  end

  def update?
    return true
  end

  def destroy?
    return true
  end

  def show?
    return true
  end

  def create?
    return true
  end
end
