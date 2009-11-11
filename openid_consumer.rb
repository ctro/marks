require 'sinatra/base'
gem 'ruby-openid', '>=2.1.2'
require 'openid'
require 'openid/store/filesystem'

module Sinatra
  module OpenIDAuth

    def openid_consumer(session)
      @openid_consumer ||= OpenID::Consumer.new(session,
      OpenID::Store::Filesystem.new("#{File.dirname(__FILE__)}/tmp/openid"))
    end

    def root_url(request)
      request.url.match(/(^.*\/{2}[^\/]*)/)[1]
    end
    
    get '/login' do
      haml :login
    end
    
    get '/logout' do
      session[:user] = nil
      redirect '/'
    end

    post '/login/openid' do
      openid = params[:openid_identifier]
      begin
        oidreq = openid_consumer(session).begin(openid)
      rescue OpenID::DiscoveryFailure => why
        flash[:error] = "Sorry, we couldn't find your identifier '#{openid}'"
        redirect "/"
      else
        redirect oidreq.redirect_url(root_url(request), root_url(request) + "/login/openid/complete")
      end
    end

    get '/login/openid/complete' do
      oidresp = openid_consumer(session).complete(params, request.url)

      case oidresp.status
      when OpenID::Consumer::FAILURE
        flash[:error] = "Sorry, we could not authenticate you with the identifier '{openid}'."
        redirect"/"

      when OpenID::Consumer::SETUP_NEEDED
        flash[:error] = "Immediate request failed - Setup Needed"
        redirect "/"

      when OpenID::Consumer::CANCEL
        flash[:error] = "Login cancelled."
        redirect "/"

      when OpenID::Consumer::SUCCESS
        flash[:notice] = "Login successful"
        # session[:user] = User.find_by_openid(oidresp.display_identifier)
        session[:user] = true
        redirect "/"
      end
    end
  end
  
  register OpenIDAuth
end