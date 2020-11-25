# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'nokogiri'

puts 'cleaning the database...'

puts 'destroying appointments...'
Appointment.destroy_all
puts 'destroying reviews...'
Review.destroy_all
puts 'destroying articles...'
Article.destroy_all
puts 'destroying doctors...'
Doctor.destroy_all
puts 'destroying users...'
User.destroy_all

print 'creating users (takes time)'

# create one specific user to work with
nada = User.new(
  first_name: 'Nada',
  last_name: 'Lakkis',
  email: 'nada@gmail.com',
  phone_number: Faker::PhoneNumber.phone_number_with_country_code,
  birth_date: Faker::Date.between(from: '1975-01-01', to: '1985-01-01'),
  gender: 'female',
  password: '123456',
  password_confirmation: '123456'
)

nada.avatar.attach(
  io: File.open('app/assets/images/clients/1.png'),
  filename: '1.png', content_type: 'image/png'
)

nada.save!

print '.'

# create random users
29.times do |i|
  avatars_asset_path = "app/assets/images/clients/"
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

puts 'scraping psychologytoday.com for doctor about information...'

about_texts = []

html_content = open('https://www.psychologytoday.com/us/therapists/ca/berkeley').read
doc = Nokogiri::HTML(html_content)
doc.search('.result-desc.hidden-sm-down').each_with_index do |element, index|
  about_texts << element.text.strip
end

html_content = open('https://www.psychologytoday.com/us/therapists/ca/los-angeles').read
doc = Nokogiri::HTML(html_content)
doc.search('.result-desc.hidden-sm-down').each_with_index do |element, index|
  about_texts << element.text.strip
end

puts "found #{about_texts.count} about texts to use."

print 'creating doctors (takes a while)'

specializations = ['ADHD', 'Addiction', 'Anger Management', 'Anxiety', 'Bipolar Disorder', 'Borderline Disorder', 'Depression', 'Eating Disorders', 'Family Conflict', 'Grief', 'Martial and Premarital', 'Relationship Issues', 'Self-esteem', 'Sex Therapy', 'Stress', 'Trauma and PTSD']

# create one specific doctor to work with
doctor_first_name = 'Nima'
doctor_last_name = 'Az'
doctor_email = 'nimad@gmail.com'

doctor_user = User.new(
  first_name: doctor_first_name,
  last_name: doctor_last_name,
  email: doctor_email,
  phone_number: Faker::PhoneNumber.phone_number_with_country_code,
  birth_date: Faker::Date.between(from: '1975-01-01', to: '1985-01-01'),
  gender: 'male',
  password: '123456',
  password_confirmation: '123456'
)

doctor_user.save!

doctor = Doctor.new(
  specializations: specializations.sample(rand(1..3)).to_s,
  first_name: doctor_first_name,
  last_name: doctor_last_name,
  email: doctor_email,
  phone_number: Faker::PhoneNumber.phone_number_with_country_code,
  about: about_texts.shift,
  user: doctor_user
)

doctor.avatar.attach(
  io: File.open('app/assets/images/therapists/1.jpg'),
  filename: '1.jpg', content_type: 'image/jpg'
)

doctor.save!

print '.'

# create random doctors
34.times do |i|
  avatars_asset_path = "app/assets/images/therapists/"
  file_name = "#{i + 2}.jpg"
  avatar_path = "#{avatars_asset_path}#{file_name}"

  # Create the doctor user -> QUICK Fix to allow the docor to log in
  doctor_first_name = Faker::Name.first_name
  doctor_last_name = Faker::Name.last_name
  doctor_email = Faker::Internet.email

  user_doctor = User.create!(
    first_name: doctor_first_name,
    last_name: doctor_last_name,
    email: doctor_email,
    password: '123456'
    )

  doctor = Doctor.new(
    specializations: specializations.sample(rand(1..3)).to_s,
    first_name: doctor_first_name,
    last_name: doctor_last_name,
    email: doctor_email,
    phone_number: Faker::PhoneNumber.phone_number_with_country_code,
    about: about_texts.shift,
    user: user_doctor
  )

  doctor.avatar.attach(
    io: File.open(avatar_path),
    filename: file_name, content_type: 'image/jpg'
  )

  doctor.save!

  print '.'
end

puts ''

puts 'scraping betterhelp.com for doctor reviews...'

reviews = []

html_content = open('https://www.betterhelp.com/reviews/').read
doc = Nokogiri::HTML(html_content)

doc.search('.quote').each_with_index do |element, index|
  reviews << element.text.strip
end

puts "found #{reviews.count} reviews to use."

print 'creating reviews for doctors (goes fast)'

Doctor.all.each do |doctor|
  rand(5..10).times do
    review = Review.new(
      doctor: doctor,
      user: User.all.sample,
      rating: rand(1..5),
      content: reviews.shift,
      date: Faker::Date.between(from: '2020-9-27', to: '2020-11-24'),
    )

    review.save!

    print '.'

    return if reviews.count.zero?
  end
end

puts ''

# print 'creating articles for doctors (goes faster)'

# Doctor.all.each do |doctor|
#   rand(1..3).times do
#     article = Article.new(
#       title: Faker::Lorem.sentence(word_count: 5),
#       content: Faker::Lorem.paragraphs(number: 20).join(' '),
#       doctor: doctor,
#     )

#     article.save!

#     print '.'
#   end
# end

# puts ''

# print 'creating some appointments for today'

# seconds_in_hour = 60 * 60
# now = Time.now
# start_time = Time.new(now.year, now.month, now.day, now.hour + 1, 0, 0)

# 8.times do
#   appointment = Appointment.new(
#     user: User.first,
#     doctor: Doctor.first,
#     status: false,
#     meeting_link: 'zoom',
#     appointment_start: start_time,
#     appointment_end: start_time + seconds_in_hour
#   )

#   appointment.save!
#   start_time += seconds_in_hour

#   if start_time.hour > 18
#     start_time = Time.new(start_time.year, start_time.month, start_time.day + 1, 9, 0, 0)
#   end

#   print '.'
# end

# puts ''

puts "first doctor id: #{Doctor.first.id}"
