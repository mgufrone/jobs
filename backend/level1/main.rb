require "json"
require "date"
# your code
data = JSON.parse File.read("data.json")
cars = data["cars"]
rentals = [];
data["rentals"].map do |e|
  car = cars.find { |car| car["id"] == e["car_id"] }
  rentals << {
    id: e["id"],
    price: (e["distance"] * car["price_per_km"]) + (((Date.parse(e["start_date"])...Date.parse(e["end_date"])).count + 1) * car["price_per_day"])
  }
end

open("output.json", "w"){|file| file.write(JSON.pretty_generate({rentals: rentals}))}
