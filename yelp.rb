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



parameters = { term: food_type,
  limit: 10,
  radius_filter: 1600, #in meters = 1 miles
  sort: 1, # 0:best matched(default), 1: distance, 2: highest rated
}

coordinates = { latitude: 37.784900, longitude: -122.397398 }

response = Yelp.client.search_by_coordinates(coordinates, parameters)
puts "*~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~*"
response.businesses.each_with_index do |x, index|
  ap "#{index}                     #{x.name}"
  # ap "#{response.location.display_address}"
  ap "Distance: #{x.distance.floor}"
  ap "Rating: #{x.rating}"
  puts "*~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~*"
end


puts "Would you like to bookmark any of these restaurants? (pick index number)"

bookmark_choice = gets.chomp

new_restaurant = Restaurant.create( name: response.businesses[bookmark_choice.to_i].name, distance: response.businesses[bookmark_choice.to_i].distance.floor, rating: response.businesses[bookmark_choice.to_i].rating )


p new_restaurant



      # t.string :name
      # t.string :address
      # t.string :address
      # t.string :phone

      # t.integer :distance
      # t.integer :rating
      # t.integer :review_count

