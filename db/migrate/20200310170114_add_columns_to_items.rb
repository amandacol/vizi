class AddColumnsToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :state, :string
    add_column :items, :item_sku,:string
    add_monetize :items, :amount, currency: { present: false }
    add_column :items, :checkout_session_id, :string
  end
end
