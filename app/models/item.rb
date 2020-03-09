class Item < ApplicationRecord
  belongs_to :user
  belongs_to :sport
  has_many :orders
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
    against: [ :name, :description, :transaction_type ],
    using: {
      tsearch: { prefix: true }
    }
end
