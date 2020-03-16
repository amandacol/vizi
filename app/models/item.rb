class Item < ApplicationRecord
  belongs_to :user
  belongs_to :sport
  has_many :orders, dependent: :destroy
  has_one_attached :photo
  has_many :wishlists, dependent: :destroy
  has_many :reviews, dependent: :destroy
  monetize :price_cents
  validates :transaction_type, inclusion: { in: ["Rental","Sale"], allow_nil: false }
  validates :description, length: { maximum: 290 }
  validates :name, length: { maximum: 25 }
  geocoded_by :address

  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
    against: [ :name, :description, :transaction_type ],
    using: {
      tsearch: { prefix: true }
    }

  def calculate_date
    #orders.where(state: 'paid').map do |order|
    orders.map do |order|
      {
        from: start_date.strftime("%m-%d-%Y"),
        to: end_date.strftime("%m-%d-%Y")
      }
    end
  end
end
