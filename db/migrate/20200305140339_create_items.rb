class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :sport
      t.string :transaction_type
      t.date :start_date
      t.date :end_date
      t.string :size
      t.integer :price
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
