require 'faker'
require 'open-uri'

puts 'Cleaning database...'
Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

puts 'Creating new database...'

URL = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
images = ["https://images.unsplash.com/photo-1530034424313-9be028eeae5a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80",
"https://images.unsplash.com/photo-1539788292313-547a2c372229?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80", "https://images.unsplash.com/photo-1541020230467-e33e4f96f7fc?ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80", "https://images.unsplash.com/photo-1541705690759-58b15944552f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1500&q=80", "https://images.unsplash.com/photo-1566805972780-0f6fbefd137b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80", "https://images.unsplash.com/photo-1506086981951-28ca31bf51dd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=668&q=80"]

data = JSON.parse(open(URL).read)
ingredients = []
data['drinks'].each do |item|
  ingredients << item['strIngredient1']
end

6.times do
  cocktail = Cocktail.new(name: Faker::Dessert.unique.flavor)
  cocktail.img = images.sample
  # cocktail.img = "http://loremflickr.com/500/280/#{cocktail.name}"
  cocktail.save
  3.times do
    ingredient = Ingredient.new(name: ingredients.sample)
    ingredient.save

    dose = Dose.new(
      description: Faker::Food.measurement,
      ingredient_id: ingredient.id,
      cocktail_id: cocktail.id
    )
    dose.save
  end
  cocktail.save
end

puts 'Database created'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
