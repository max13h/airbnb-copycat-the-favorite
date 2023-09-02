require "open-uri"
require "nokogiri"
require "faker"

u = User.count
l = Lens.count
c = Camera.count

puts "There is #{u} users, #{l} lenses and #{c} cameras in you database"
puts "Do you want to continue (y/n)"
input = gets.chomp

return unless input == "y" || input == "Y"

puts "Clear database..."
puts ""

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
# ============================================

puts ""

# Create cameras ======================
camera_url = "https://www.borrowlenses.com/rent/category/rentalgear/cameras?q=%3AmostPopular%3Acategory%3Acameras&text=&clearBrands="

camera_html_file = URI.open(camera_url).read
camera_html_doc = Nokogiri::HTML.parse(camera_html_file)
camera_count = 1
random_nb = rand(5..8)

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

puts ""

# Create lenses # =============================

lenses_type = ["Wide", "Normal", "Ultrawide", "Macro"]
city = ["London", "Paris", "Madrid", "Berlin"]
lens_count = 1

lenses_type.each do |lens_type|
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
        name: name,
        lens_type: lens_type,
        price: rand(70..200),
        location: city.sample,
        user: User.all.sample,
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

# ============================================

puts "Database successfully filled !"
