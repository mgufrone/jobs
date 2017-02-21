require "json"
require "date"
# your code
def price_km (per_km, distance)
  per_km * distance
end
def get_days(start_date, end_date)
  (Date.parse(start_date)...Date.parse(end_date)).count + 1
end
def price_day(per_day, days)
  per_day * days
end

data = JSON.parse File.read("data.json")
cars = data["cars"]
rentals = [];
data["rentals"].map do |e|
  car = cars.find { |car| car["id"] == e["car_id"] }
  rentals << {
    id: e["id"],
    price: price_km(car["price_per_km"], e["distance"]) + price_day(car["price_per_day"], get_days(e["start_date"], e["end_date"]))
  }
end

open("output.json", "w"){|file| file.write(JSON.pretty_generate({rentals: rentals}))}
