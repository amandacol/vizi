class AddImagesToSports < ActiveRecord::Migration[5.2]
  def change
    add_column :sports, :image, :string
  end
end
