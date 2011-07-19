module BarManitto
  class Tweet
    include DataMapper::Resource
    
    property :id,                   Serial
    property :text,                 Text
    property :to_user_id,           Integer
    property :to_user,              String, :length => 255
    property :from_user,            String, :length => 255
    property :original_id,          Integer
    property :from_user_id,         Integer
    property :profile_image_url,    String, :length => 255
    property :original_created_at,  DateTime
    property :created_at,           DateTime
  end
end
