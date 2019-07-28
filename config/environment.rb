require 'sinatra/activerecord'
require 'require_all'
require 'tty-prompt'
require 'paint'
require_all 'app'
# require 'pry'

# established connection to database
connection = ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/flatiron.db')
# eliminates message logging to terminal.
ActiveRecord::Base.logger = nil


# play_game
