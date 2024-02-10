# frozen_string_literal: true

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

# 50.times do |_index|
#   Bulletin.create!(
#     title: Faker::ChuckNorris.fact,
#     description: Faker::Lorem.paragraphs(number: 2).join(' '),
#     category: category1,
#     creator: 1
#   )
# end

# Seed categories
categories = Category.create([
                               { name: 'Category 1' },
                               { name: 'Category 2' },
                               { name: 'Category 3' }
                             ])

# Seed users
users = User.create([
                      { name: 'John Doe', email: 'john@example.com', admin: true },
                      { name: 'Jane Smith', email: 'jane@example.com', admin: false }
                    ])

# Seed bulletins
states = %w[draft under_moderation published rejected archived]
images = ['image1.jpg', 'image2.jpg', 'image3.jpg']

50.times do |_index|
  b = Bulletin.create(
    title: Faker::Lorem.word,
    description: Faker::ChuckNorris.fact,
    category: categories.sample,
    creator: users.sample,
    state: states.sample
  )
  b.image.attach(
    io: File.open(Rails.root.join("test/fixtures/files/#{images.sample}").to_s),
    filename: images.sample
  )
  b.save
end
