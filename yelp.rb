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

@response = Yelp.client.search_by_coordinates(coordinates, parameters)
puts "*~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~*"
@response.businesses.each do |x|
  puts "                     #{x.name} "
  ap "Distance: #{x.distance.floor}"
  ap "Rating: #{x.rating}"
  puts "*~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~**~*~*~*~*"
end
#puts response.businesses[0].rating

# puts response.businesses[0].display_address




require_relative '../../config/application'


def show_bookmarks
  Restaurant.all.each_with_index do |restaurant, index|
    restaurant_display(restaurant, index)
  end
end

def restaurant_display(restaurant, index)
  puts "\n::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
  puts "#{ index + 1 }: #{restaurant.name}".white_on_blue
  ap "Distance: #{restaurant.distance} meters"
  ap "Rating: #{restaurant.rating}"
end

def show_results(result)
  puts "\n::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
  result.businesses.each_with_index do |x, index|
    ap "#{index}                     #{x.name}"
    # ap "#{response.location.display_address}"
    ap "Distance: #{x.distance.floor}"
    ap "Rating: #{x.rating}"
    puts "\n::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
  end
  bookmark(result)
end

def bookmark(response)
  puts "Would you like to bookmark any of these restaurants? (yes or no)".cyan
  first_choice = gets.chomp.downcase
  if first_choice == "yes"
    puts "What number do you want to bookmark?".cyan
    bookmark_choice = gets.chomp
    restaurant_obj = response.businesses[bookmark_choice.to_i]
    new_restaurant = Restaurant.create( name: restaurant_obj.name, distance: restaurant_obj.distance.floor, rating: restaurant_obj.rating )
    puts "#{new_restaurant.name} has been bookmarked.".cyan
  else
    return "Thanks for using Yelpie".cyan
  end

end

@coordinates = { latitude: 37.784900, longitude: -122.397398 }

def search(term)
  parameters = { term: term,
    limit: 10,
  radius_filter: 1600, #in meters = 1 miles
  sort: 1, # 0:best matched(default), 1: distance, 2: highest rated
}
@response = Yelp.client.search_by_coordinates(@coordinates, parameters)

end

def start
  puts "                                     ".white_on_cyan
  puts "*~*~*~*~* WELCOME TO YELPIE *~*~*~*~*".white_on_cyan.bold
  puts "                                     ".white_on_cyan
  sleep(0.5)
  puts "    lazy and hungry DBC students    ".bold.cyan
  puts ""
  loop do
    puts "What would you like to do: ".cyan + "search".underline.red + ", " + "view".underline.red + " bookmarks" + ", or " + "exit".underline.red + "?".cyan
    @user_choice = gets.chomp
    case @user_choice.downcase
    when "search"
      puts "\nWhat type of food do you want to devour?".cyan
      food_type = gets.chomp
      search(food_type)
      show_results(@response) if @response.businesses != []
      puts ""

    when "view"
      show_bookmarks

    when "exit"
      abort("Thanks for using our awesome app.".red)

    end
  end
end
