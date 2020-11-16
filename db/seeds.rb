# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'cleaning the database...'

Review.destroy_all
Article.destroy_all
Doctor.destroy_all
User.destroy_all
# Appointment.destroy_all

print 'creating users (takes time)'

nima = User.new(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: 'nima@gmail.com',
  phone_number: Faker::PhoneNumber.phone_number_with_country_code,
  birth_date: Faker::Date.between(from: '1975-01-01', to: '1985-01-01'),
  gender: 'male',
  password: '123456',
  password_confirmation: '123456'
)

nima.avatar.attach(
  io: File.open('app/assets/images/avatars/1.png'),
  filename: '1.png', content_type: 'image/png'
)

nima.save!

print '.'

14.times do |i|
  avatars_asset_path = "app/assets/images/avatars/"
  file_name = "#{i + 2}.png"
  avatar_path = "#{avatars_asset_path}#{file_name}"

  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.phone_number_with_country_code,
    birth_date: Faker::Date.between(from: '1975-01-01', to: '1985-01-01'),
    gender: Faker::Gender.type,
    password: '123456',
    password_confirmation: '123456'
  )

  user.avatar.attach(
    io: File.open(avatar_path),
    filename: file_name, content_type: 'image/png'
  )

  user.save!

  print '.'
end

puts ''

print 'creating doctors (takes a while)'

15.times do |i|
  avatars_asset_path = "app/assets/images/avatars/"
  file_name = "#{i + 1}.png"
  avatar_path = "#{avatars_asset_path}#{file_name}"

  specializations = []

  rand(1..3).times do
    specializations << Faker::Lorem.word
  end

  doctor = Doctor.new(
    specializations: specializations.to_s,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.phone_number_with_country_code,
    about: Faker::Lorem.paragraph(sentence_count: 10)
  )

  doctor.avatar.attach(
    io: File.open(avatar_path),
    filename: file_name, content_type: 'image/png'
  )

  doctor.save!

  print '.'
end

puts ''

print 'creating reviews for doctors (goes fast)'

Doctor.all.each do |doctor|
  rand(5..10).times do
    review = Review.new(
      doctor: doctor,
      user: User.all.sample,
      rating: rand(1..5),
      content: Faker::Lorem.paragraph(sentence_count: 10),
      date: Faker::Date.between(from: '2020-9-27', to: '2020-11-24'),
    )

    review.save!

    print '.'
  end
end

puts ''

print 'creating articles for doctors (goes faster)'

Doctor.all.each do |doctor|
  rand(1..3).times do
    article = Article.new(
      title: Faker::Lorem.sentence(word_count: 5),
      content: Faker::Lorem.paragraphs(number: 20).join(' '),
      doctor: doctor,
    )

    article.save!

    print '.'
  end
end

puts ''
puts "first doctor id: #{Doctor.first.id}"
