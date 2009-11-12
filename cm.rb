require 'rubygems'
require 'sinatra'
require 'rack-flash'
require 'openid_consumer'
require 'models'


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
