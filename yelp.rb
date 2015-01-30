require_relative 'config/application'

# puts "Put your application code in #{File.expand_path(__FILE__)}"


# Controller.options(ARGV[0], ARGV[1..-1])
# options = ['search', 'display  ]


puts "*~*~*~*~* WELCOME TO YELPIE *~*~*~*~*"
sleep(0.5)
puts "...for broke ass DBC students"
sleep(1.5)
puts "What type of food do you want to devour"
food_type = gets.chomp
puts

# YOUR_CONSUMER_KEY = 'QCX_Wf09d5RnoOr6MaGl1w'
# YOUR_CONSUMER_SECRET = '9iRHa1wyKwO_76knQis0K--13VQ'
# YOUR_TOKEN = 'clnRjAu8W4Vdd9LY8Hu4bOrdI2IBO2RV'
# YOUR_TOKEN_SECRET = 'Y0GvcKDj0tpzQfB6JsJrWxPrR68'


Yelp.client.configure do |config|
  config.consumer_key = 'QCX_Wf09d5RnoOr6MaGl1w'
  config.consumer_secret = '9iRHa1wyKwO_76knQis0K--13VQ'
  config.token = 'clnRjAu8W4Vdd9LY8Hu4bOrdI2IBO2RV'
  config.token_secret = 'Y0GvcKDj0tpzQfB6JsJrWxPrR68'
end


parameters = { term: food_type,
  limit: 10,
  radius_filter: 1600, #in meters = 1 miles
  sort: 1, # 0:best matched(default), 1: distance, 2: highest rated
}

coordinates = { latitude: 37.784900, longitude: -122.397398}

response = Yelp.client.search_by_coordinates(coordinates, parameters)
puts "*~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~*"
response.businesses.each do |x|
  ap x.name
  ap x.distance.floor
  ap x.rating
  puts "*~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~*"
end
#puts response.businesses[0].rating

# puts response.businesses[0].display_address
