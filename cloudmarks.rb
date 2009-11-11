require 'rubygems'
require 'sinatra'
require 'dm-core'

# DataMapper setup
# http://datamapper.org/getting-started.html
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/cloudmarks.sqlite3")

class Mark
  include DataMapper::Resource

  property :id,         Serial
  property :title,      String
  property :uri,        String
  property :created_at, DateTime
end

DataMapper.auto_upgrade!

# index
get '/' do
  erb :index
end

