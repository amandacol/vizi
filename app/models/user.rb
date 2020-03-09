class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  geocoded_by :address
  has_many :orders
  has_many :items
  has_many :wishlists

  has_one_attached :photo
  validates :name, :surname, :address, presence: true, on: :update

  after_validation :geocode, if: :will_save_change_to_address?

end
