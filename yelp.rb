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

def show_results
  puts "*~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~*"
  response.businesses.each_with_index do |x, index|
    ap "#{index}                     #{x.name}"
    # ap "#{response.location.display_address}"
    ap "Distance: #{x.distance.floor}"
    ap "Rating: #{x.rating}"
    puts "*~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~*"
  end
end

def bookmark(response)
  puts "Would you like to bookmark any of these restaurants? (yes or no)"
  first_choice = gets.chomp.downcase
  if first_choice == "yes"
    bookmark_choice = gets.chomp
    restaurant_obj = response.businesses[bookmark_choice.to_i]
    new_restaurant = Restaurant.create( name: restaurant_obj.name, distance: restaurant_obj.distance.floor, rating: restaurant_obj.rating )
    puts "#{new_restaurant.name} has been bookmarked."
  else
    return "Thanks for using Yelpie"
  end

end

@coordinates = { latitude: 37.784900, longitude: -122.397398 }

def search(term)
  parameters = { term: term,
    limit: 10,
  radius_filter: 1600, #in meters = 1 miles
  sort: 1, # 0:best matched(default), 1: distance, 2: highest rated
}
  response = Yelp.client.search_by_coordinates(@coordinates, parameters)
  bookmark(response)
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
  search(food_type)
  show_results
  puts ""

when "view"
  show_bookmarks
end












      # t.string :name
      # t.string :address
      # t.string :address
      # t.string :phone

      # t.integer :distance
      # t.integer :rating
      # t.integer :review_count

