class RemoveSportTagFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :sport_tag, :string
  end
end
