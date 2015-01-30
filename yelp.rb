require_relative 'config/application'

# puts "Put your application code in #{File.expand_path(__FILE__)}"


# Controller.options(ARGV[0], ARGV[1..-1])
def show_bookmarks
  Restaurant.all.each_with_index do |restaurant, index|
        restaurant_display(restaurant, index)
      end
end

def restaurant_display(restaurant, index)
  puts "*~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~*"
        puts "#{ index + 1 }: #{restaurant.name}"
        puts "Distance: #{restaurant.distance} meters"
        puts "Rating: #{restaurant.rating}"
end


puts "*~*~*~*~* WELCOME TO YELPIE *~*~*~*~*"
sleep(0.5)
puts "...for broke ass DBC students"
sleep(1.5)
puts "What would you like to do: search or view bookmarks"
@user_choice = gets.chomp
case @user_choice
when "search"
  puts "What type of food do you want to devour?"
  food_type = gets.chomp
when "view"
  show_bookmarks
end






parameters = { term: food_type,
  limit: 10,
  radius_filter: 1600, #in meters = 1 miles
  sort: 1, # 0:best matched(default), 1: distance, 2: highest rated
}

coordinates = { latitude: 37.784900, longitude: -122.397398 }

response = Yelp.client.search_by_coordinates(coordinates, parameters)
puts "*~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~*"
response.businesses.each do |x|
  ap "                     #{x.name}"
  ap "Distance: #{x.distance.floor}"
  ap "Rating: #{x.rating}"
  puts "*~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~*"
end
#puts response.businesses[0].rating

# puts response.businesses[0].display_address
#name, distance, rating
#

