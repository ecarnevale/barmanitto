$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'bar_manitto'
require 'sinatra'

get '/' do
  @tweets = BarManitto::Tweet.all(:order => [:created_at.desc], :limit => 10)
  erb :index
end