class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  monetize :amount_cents

  def paid?
    state == "paid"
  end
end
