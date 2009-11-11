require 'rubygems'
require 'sinatra'
require 'dm-core'

# DataMapper setup
# http://datamapper.org/getting-started.html
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/cloudmarks.sqlite3")

class User
  include DataMapper::Resource
  
  has n :marks
  
  property :id,         Serial
  property :name,       String
  property :created_at, DateTime
end

class Mark
  include DataMapper::Resource
  
  has 1 :user

  property :id,         Serial
  property :user_id,    Serial
  property :title,      String, :nullable => false
  property :uri,        String, :nullable => false
  property :x,          Serial, :default => 33
  property :y,          Serial, :default => 33
  property :created_at, DateTime
end

DataMapper.auto_upgrade!

# index
get '/' do
  erb :index
end

