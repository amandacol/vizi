class AddRentStartDateToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :rent_start_date, :string
  end
end
