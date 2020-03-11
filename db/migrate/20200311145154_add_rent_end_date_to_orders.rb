class AddRentEndDateToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :rent_end_date, :string
  end
end
