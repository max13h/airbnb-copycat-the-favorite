require "open-uri"
require "nokogiri"

url = "./db/website.html"

html_file = URI.open(url).read
html_doc = Nokogiri::HTML.parse(html_file)

html_doc.search(".card").each do |element|
  camera_brand = element.search(".overline").text

  title = element.search(".product a").text
  puts title

end