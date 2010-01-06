require 'dm-core'
require 'dm-ar-finders'
require 'dm-timestamps'
require 'dm-validations'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/marks.sqlite3")
class User
  include DataMapper::Resource

  property :id,         Serial
  property :openid,     String,   :required => true
  property :created_at, DateTime
  
  has n, :marks
end

class Mark
  include DataMapper::Resource
  
  property :id,         Serial
  property :name,       String,  :required => true
  property :uri,        String,  :required => true, :format => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
  property :clicks,     Integer, :default => 0
  property :accesskey,  String,  :length => 1
  property :created_at, DateTime
  
  belongs_to :user
end
DataMapper.auto_upgrade!