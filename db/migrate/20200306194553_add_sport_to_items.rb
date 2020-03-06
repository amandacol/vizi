class AddSportToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :sport, index: true
  end
end
