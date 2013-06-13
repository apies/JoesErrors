require 'pry'
require './lib/joe_error.rb'
require './lib/joe_logger.rb'
require './lib/joe_error_handler.rb'
require './lib/joe_requester.rb'
require 'rspec/mocks'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3', # or 'postgresql' or 'sqlite3'
  database: './faux_data/development.sqlite3',
  pool: 5,
  timeout: 5000
)

RSpec.configure do |config|
  #config.filter_run :focus => true
end