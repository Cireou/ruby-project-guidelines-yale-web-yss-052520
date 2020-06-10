require 'bundler'
Bundler.require

require 'active_record'
require "tty-prompt"
require 'dotenv'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3', 
  database: 'db/development.db'
  )

ActiveRecord::Base.logger = nil
require_all 'lib'
require_all 'app/models'