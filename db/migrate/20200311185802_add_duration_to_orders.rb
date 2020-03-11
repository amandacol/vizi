class AddDurationToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :duration, :string
  end
end
