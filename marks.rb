require 'rubygems'
require 'sinatra'
require 'rack-flash'
require 'openid_consumer'
require 'models'
require 'haml'
require 'sass'


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

get '/marks/go/:id' do
  protected!
  mark = @user.marks.first(:id => params[:id])
  mark.update(:clicks => mark.clicks + 1)
  redirect mark.uri.to_s
end

get '/marks/destroy/:id' do
  protected!
  @user.marks.first(:id => params[:id]).destroy
  redirect '/'
end