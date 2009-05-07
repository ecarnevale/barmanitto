$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'bar_manitto'
require 'sinatra'

helpers do
  def tweet_links(text)
    text.gsub(/@\w+/) do |match|
      screen_name = match[1, match.size - 1]
      %|<a href="http://twitter.com/#{screen_name}">@#{screen_name}</a>|
    end
  end
end

get '/' do
  @offset = @params[:offset].to_i > 0 ? params[:offset].to_i : 0
  @tweets = BarManitto::Tweet.all(:order => [:created_at.desc], :limit => 10, :offset => @offset)
  erb :index, :layout => !request.xhr?
end