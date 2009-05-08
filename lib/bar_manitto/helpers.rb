module BarManitto
  module Helpers
    def config
      BarManitto.config
    end
    
    def tweet_links(text)
      text.gsub(/@\w+/) do |match|
        screen_name = match[1, match.size - 1]
        %|<a href="http://twitter.com/#{screen_name}">@#{screen_name}</a>|
      end
    end
  end
end