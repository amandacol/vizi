class Item < ApplicationRecord
  belongs_to :user
  has_many :order
  has_one_attached :photo


  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
    against: [ :name, :description, :sport, :transaction_type ],
    using: {
      tsearch: { prefix: true }
    }

end
