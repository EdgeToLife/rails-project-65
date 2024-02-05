# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# 5.times do |_index|
#   Category.create!(
#     name: Faker::Game.unique.genre
#   )
# end

# 3.times do |index|
#   User.create!(
#     id: index+2,
#     email: "user#{index}@example.com",
#   )
# end

# 5.times do |_index|
#   Bulletin.create!(
#     title: Faker::ChuckNorris.fact,
#     description: Faker::Lorem.paragraphs(number: 2).join(' '),
#     category: category1,
#     creator: 1
#   )
# end
