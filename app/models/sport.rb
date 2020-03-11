class Sport < ApplicationRecord
  has_many :items
  has_many :user_sports
  has_many :users, through: :user_sports

end
