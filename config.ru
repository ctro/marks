require 'rubygems'
gem 'sinatra'
set :run, false
set :environment, :production
run Sinatra::Application
