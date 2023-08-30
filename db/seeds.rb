require "open-uri"
require "nokogiri"
require "faker"
require "watir"

# Create cameras ======================
camera_url = "https://www.borrowlenses.com/rent/category/rentalgear/cameras?q=%3AmostPopular%3Acategory%3Acameras&text=&clearBrands="

camera_html_file = URI.open(camera_url).read
camera_html_doc = Nokogiri::HTML.parse(camera_html_file)
camera_count = 1
random_nb = rand(5..8)


camera_html_doc.search(".card").each do |element|
  break if camera_count == random_nb

  camera_brand = element.search(".overline").text.capitalize
  camera_model_raw = element.search(".product a").text.split(' ').reject {|e| e.capitalize == camera_brand}
  camera_model = camera_model_raw.join(" ")

  Camera.create!(brand: camera_brand, model: camera_model)

  puts "Camera nb #{camera_count} created "
  
  camera_count += 1
end
# ============================================

# Create users # =============================
user_count = 1
rand(6..10).times do
  User.create!(email: Faker::Internet.email, password: Faker::Internet.password, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)

  puts "User nb #{user_count} created "

  user_count += 1
end
# ============================================

# Create lenses # =============================

lenses_type = ["Wide", "Normal", "Ultrawide", "Macro"]
city = ["London", "Paris", "Madrid", "Berlin"]
browser = Watir::Browser.new :chrome

lenses_type.each do |lens_type|
  puts "lenses of type #{lens_type}"
  puts ""
  lens_url = "https://www.borrowlenses.com/rent/category/rentalgear/lenses?q=%3AmostPopular%3ALenses+Type%3A#{lens_type}&text=&clearBrands=&Lenses+Type-#{lens_type}=on"

  browser.goto lens_url
  sleep 3

  lens_html_doc = Nokogiri::HTML.parse(browser.html)

  lens_count = 1
  # random_nb = rand(3..6)


  lens_html_doc.search(".card").each do |element|
    # break if lens_count == random_nb

    name = element.search(".product a").attribute("data-productname")
    puts name

    unless name
      next
    end

    price =  element.search(".price").text.tr("$", "").chomp.to_i
    location = city.sample
    user = User.all.sample
    camera = Camera.all.sample

    Lens.create!(
      name: name,
      lens_type: lens_type,
      price: price,
      location: location,
      user: user,
      camera: camera
    )

    puts "Lens nb #{lens_count} created "

    # lens_count += 1
  end
  puts ""
end
# ============================================