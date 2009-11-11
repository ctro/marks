require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'openid_consumer'
require 'rack-flash'

### DataMapper
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/cm.sqlite3")
class User
  include DataMapper::Resource
  
  has n, :marks
  
  property :id,         Serial
  property :openid,     String
  property :created_at, DateTime
end

class Mark
  include DataMapper::Resource
  
  has 1, :user

  property :id,         Serial
  property :user_id,    Integer
  property :title,      String, :nullable => false
  property :uri,        String, :nullable => false
  property :x,          Integer, :default => 33
  property :y,          Integer, :default => 33
  property :created_at, DateTime
end
DataMapper.auto_upgrade!

### Sinatra
enable :sessions
use Rack::Flash

get '/style.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :style
end

# index
get '/' do
  haml :index
end

