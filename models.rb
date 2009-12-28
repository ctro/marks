require 'dm-core'
require 'dm-ar-finders'
require 'dm-types'
require 'dm-timestamps'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/marks.sqlite3")
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
  property :name,       String,  :required => true
  property :uri,        URI,     :required => true
  property :clicks,   Integer, :default => 0
  property :key,        String
  property :created_at, DateTime
  
  belongs_to :user
end
DataMapper.auto_upgrade!