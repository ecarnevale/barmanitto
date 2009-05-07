require 'rubygems'
require 'dm-core'
require 'twitter'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/barmanitto.sqlite3")

require 'bar_manitto/crawler'
require 'bar_manitto/tweet'



