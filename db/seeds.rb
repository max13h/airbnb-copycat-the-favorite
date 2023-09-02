require "open-uri"
require "nokogiri"
require "faker"

u = User.count
l = Lens.count
c = Camera.count
b = Booking.count

puts "There is #{u} users, #{l} lenses, #{b} bookings and #{c} cameras in you database"
puts "Do you want to continue (y/n)"
input = gets.chomp

return unless input == "y" || input == "Y"

puts "Clear database..."
puts ""

Booking.destroy_all
Lens.destroy_all
User.destroy_all
Camera.destroy_all

puts "Database empty"
puts ""

# Create users # =============================
user_count = 1
rand(10..15).times do
  User.create!(email: Faker::Internet.email, password: Faker::Internet.password, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)

  puts "User nb #{user_count} created "

  user_count += 1
end

puts ""

puts "Creating default user"

default_user = User.create!(email: "default@gmail.com", password: 1234567890, first_name: "Default", last_name: "User")
# ============================================

puts ""

# Create cameras ======================
camera_url = "https://www.borrowlenses.com/rent/category/rentalgear/cameras?q=%3AmostPopular%3Acategory%3Acameras&text=&clearBrands="

camera_html_file = URI.open(camera_url).read
camera_html_doc = Nokogiri::HTML.parse(camera_html_file)
camera_count = 1
random_nb = rand(8..10)

camera_html_doc.search("#matchingProducts .card").each do |element|
  break if camera_count == random_nb

  camera_brand = element.search(".overline").text.capitalize
  camera_model_raw = element.search(".product a").text.split.reject { |e| e.capitalize == camera_brand }
  camera_model = camera_model_raw.join(" ")

  Camera.create!(brand: camera_brand, model: camera_model)

  puts "Camera nb #{camera_count} created "

  camera_count += 1
end
# ============================================

# Create lenses # =============================

lenses_type = ["Wide", "Normal", "Ultrawide", "Macro"]
city = ["London", "Paris", "Madrid", "Berlin"]
lens_count = 1

lenses_type.each do |lens_type|
  puts ""
  puts "Lenses of type #{lens_type}"
  puts ""

  lenses_url = "https://www.borrowlenses.com/rent/category/rentalgear/lenses?q=%3AmostPopular%3ALenses+Type%3A#{lens_type}&text=&clearBrands=&Lenses+Type-#{lens_type}=on"

  lenses_response = URI.open(lenses_url).read
  lenses_html = Nokogiri::HTML.parse(lenses_response)

  lenses_html.search("#matchingProducts .card").each do |card|
    image_url = card.search("img").attribute("src").value
    image_url = "https://www.borrowlenses.com#{image_url}" unless image_url.include?("https://")

    name = card.search(".product a").text.strip

    lens = Lens.new(
      {
        name:,
        lens_type:,
        price: rand(70..200),
        location: city.sample,
        user: User.where.not(email: default_user.email).sample,
        camera: Camera.all.sample
      }
    )

    lens.image.attach(io: URI.open(image_url), filename: "#{name}.jpg")

    lens.save!

    puts "Lens nb #{lens_count} created"

    lens_count += 1
  end
end

puts ""
puts "Assigning lenses to default user"
puts ""

rand(3..5).times do
  default_user_lens = Lens.where(location: "Paris").sample
  default_user_lens.user = default_user
  default_user_lens.save!
end

# ============================================

puts ""

# Create bookings # =============================

rand(30..40).times do
  def create_samples(default_user)
    lens = Lens.all.sample
    owner = lens.user

    customer = User.all.sample

    return create_samples(default_user) if owner == customer || customer == default_user

    return [lens, customer]
  end

  lens, customer = create_samples(default_user)

  Booking.create!(
    lens:,
    user: customer,
    start_date: Faker::Date.between_except(from: Date.today, to: 2.weeks.from_now, excepted: Date.today),
    end_date: Faker::Date.between(from: 2.weeks.from_now, to: 4.weeks.from_now)
  )
end

# =====

puts "Creating bookings for default user"
puts ""
puts "Past"
rand(6..10).times do
  Booking.create!(
    lens: Lens.where(location: "Paris").sample,
    user: default_user,
    start_date: Faker::Date.between(from: 5.weeks.ago, to: 4.weeks.ago),
    end_date: Faker::Date.between(from: 3.weeks.ago, to: 1.weeks.from_now)
  )
end

puts ""
puts "Future"
rand(6..10).times do
  Booking.create!(
    lens: Lens.where(location: "London").sample,
    user: default_user,
    start_date: Faker::Date.between(from: 2.weeks.from_now, to: 3.weeks.from_now),
    end_date: Faker::Date.between(from: 4.weeks.from_now, to: 5.weeks.from_now)
  )
end

# ============================================
puts ""

puts "Database successfully filled !"
puts ""
puts "DEFAULT USER =========="
puts "email: #{default_user.email}"
puts "password: 1234567890"
puts "===================="
