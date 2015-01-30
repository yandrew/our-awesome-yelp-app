require 'pathname'
require 'sqlite3'
require 'active_record'
require 'logger'
require 'hirb'
require 'yelp'
require 'awesome_print'

Hirb.enable({ width: 250})
APP_ROOT = Pathname.new(File.expand_path(File.join(File.dirname(__FILE__), '..')))

APP_NAME = APP_ROOT.basename.to_s

DB_PATH  = APP_ROOT.join('db', APP_NAME + ".db").to_s

if ENV['DEBUG']
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

# Automatically load every file in APP_ROOT/app/models/*.rb, e.g.,
#   autoload "Person", 'app/models/person.rb'
#
# See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html

Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
  filename = File.basename(model_file).gsub('.rb', '')
  autoload ActiveSupport::Inflector.camelize(filename), model_file
end

ActiveRecord::Base.establish_connection :adapter  => 'sqlite3',
                                        :database => DB_PATH

require APP_ROOT.join('app', 'controllers', 'controller.rb')
# require APP_ROOT.join('yelp.rb')

#*** Yelp api *************************************************

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
