class AddExtentToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :extent, :string
  end
end
