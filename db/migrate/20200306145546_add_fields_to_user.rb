class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :address, :string
    add_column :users, :description, :string
    add_column :users, :photo, :string
    add_column :users, :sport_tag, :string
  end
end
