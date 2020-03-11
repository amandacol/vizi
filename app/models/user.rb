class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  geocoded_by :address
  has_many :items, dependent: :destroy


  has_many :orders
  has_many :wishlists

  has_many :user_sports
  has_many :sports, through: :user_sports

  has_one_attached :photo
  validates :name, :surname, :address, presence: true, on: :update

  after_validation :geocode, if: :will_save_change_to_address?

   include PgSearch::Model
  pg_search_scope :search_by_name_and_surname,
    against: [ :name, :surname],
    using: {
      tsearch: { prefix: true }
    }
end

