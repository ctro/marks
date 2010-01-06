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

get '/marks/go/:id' do
  protected!
  mark = @user.marks.first(:id => params[:id])
  mark.update(:clicks => mark.clicks + 1)
  redirect mark.uri.to_s
end

#CRUD
post '/' do
  protected!
  mark = Mark.create(params[:mark].merge!(:user_id => @user.id))
  set_errors(mark)
  redirect '/'
end

put '/:id' do
  protected!
  mark = @user.marks.get(params[:id])
  mark.attributes = params[:mark]
  mark.save
  set_errors(mark)
  redirect '/'
end

get '/destroy/:id' do
  protected!
  mark = @user.marks.get(params[:id])
  mark.destroy
  redirect '/'
end

private
def set_errors(mark)
  if mark.errors.empty?
    flash[:notice] = "Yep, that worked."
  else
    flash[:error] = "Oops, try again:<br/>#{mark.errors.full_messages.join('<br/>')}"
  end
end