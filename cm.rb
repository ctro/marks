require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-ar-finders'
require 'dm-types'
require 'dm-timestamps'
require 'openid_consumer'
require 'rack-flash'

### DataMapper
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/cm.sqlite3")
class User
  include DataMapper::Resource

  property :id,         Serial
  property :openid,     String
  property :created_at, DateTime
  
  has n, :marks
end

class Mark
  include DataMapper::Resource
  
  property :id,         Serial
  property :name,       String,  :nullable => false
  property :uri,        URI,     :nullable => false
  property :x,          Integer, :default => 33
  property :y,          Integer, :default => 33
  property :width,      Integer, :default => 111
  property :height,     Integer, :default => 111
  property :created_at, DateTime
  
  belongs_to :user
end
DataMapper.auto_upgrade!

### Sinatra
enable :sessions
use Rack::Flash

helpers do
  def protected!
    redirect '/login' unless session[:user_id]
  end
end

before do
  @user = (User.first(:id => session[:user_id]) rescue nil)
end

get '/style.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :style
end

get '/' do
  protected!
  haml :index
end

post '/marks' do
  protected!
  Mark.create(params[:mark].merge!(:user_id => @user.id))
  redirect '/'
end

post '/marks/:id/pos' do
  protected!
  @user.marks.first(:id => params[:id]).update_attributes(:x => params[:x], :y => params[:y])
end
