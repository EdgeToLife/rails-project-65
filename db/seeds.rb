# frozen_string_literal: true

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

5.times do |_index|
  b = Bulletin.create(
    title: Faker::Lorem.word,
    description: Faker::ChuckNorris.fact,
    category: categories.sample,
    user: users.sample,
    state: states.sample
  )
  b.image.attach(
    io: File.open(Rails.root.join("test/fixtures/files/#{images.sample}").to_s),
    filename: images.sample
  )
  b.save
end
