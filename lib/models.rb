require 'dm-core'
require 'dm-ar-finders'
require 'dm-types'
require 'dm-timestamps'

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