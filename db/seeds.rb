require 'faker'
require 'open-uri'

puts 'Cleaning database...'
Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

puts 'Creating new database...'

URL = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"

data = JSON.parse(open(URL).read)
ingredients = []
data['drinks'].each do |item|
  ingredients << item['strIngredient1']
end

15.times do
  cocktail = Cocktail.new(name: Faker::Dessert.unique.flavor)
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
