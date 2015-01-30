# require_relative 'config/application'
require 'sinatra'
require 'shotgun'

get '/' do
  erb :home
end

post '/' do

rest = Restaurant.new
rest.address = params[:location]
rest.name = 'Chaat'
rest.save
#  parameters = { term: params[:type],
#   limit: 10,
#   radius_filter: 1600, #in meters = 1 miles
#   sort: 1, # 0:best matched(default), 1: distance, 2: highest rated
# }

# coordinates = { latitude: 37.784900, longitude: -122.397398 }

# response = Yelp.client.search(params[:location], parameters)


  # n = Note.new
  # n.content = params[:content]
  # n.created_at = Time.now
  # n.updated_at = Time.now
  # n.save
  # redirect '/'
end

not_found do
  halt 404, 'woaaahhh, wooahh, woah..... hold up..'
end

# get '/hello/:name' do
#   params[:name]
# end