# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'cleaning the database...'

Review.destroy_all
Doctor.destroy_all
User.destroy_all
# Article.destroy_all
# Appointment.destroy_all

print 'creating users'

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

nima.save!

print '.'

14.times do |i|
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

  user.save!

  print '.'
end

puts ''

print 'creating doctors'

15.times do |i|
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

  doctor.save!

  print '.'
end

puts ''

print 'creating reviews for doctors'

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
