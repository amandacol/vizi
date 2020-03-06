class RemoveSportFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :sport
  end
end
