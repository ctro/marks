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

post '/marks/:id/pos' do
  protected!
  @user.marks.first(:id => params[:id]).update(:x => params[:x].to_i.abs, :y => params[:y].to_i.abs)
end

post '/marks/:id/size' do
  protected!
  @user.marks.first(:id => params[:id]).update(:width => params[:width].to_i.abs, :height => params[:height].to_i.abs)
end
