# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'

puts 'destroying all sports'
Sport.destroy_all

puts 'fetching sports from API'
url = 'https://sports.api.decathlon.com/sports'
list = open(url).read
sports_list = JSON.parse(list)

puts 'creating sports:'
sports_list['data'].each do |item|
  printf("\rCreating %s", item['attributes']['name'])
  Sport.create!(
    name: item['attributes']['name']
  )

  # puts item['attributes']['name']
  #print "\n" se quiser printar na tela do terminal
end
