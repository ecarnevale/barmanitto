$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'bar_manitto'
require 'sinatra'

configure { BarManitto.init }
helpers   { include BarManitto::Helpers }

get '/' do
  @offset = @params[:offset].to_i > 0 ? params[:offset].to_i : 0
  @tweets = BarManitto::Tweet.all(:order => [:created_at.desc], :limit => 10, :offset => @offset)
  erb :index, :layout => !request.xhr?
end