module BarManitto
  class Crawler
    def initialize(query)
      @query = query
    end

    def crawl
      Twitter::Search.new(@query).each do |message|
        unless Tweet.first(:original_id => message.id)
          Tweet.create(
            :text                 => message.text,
            :to_user_id           => message.to_user_id,
            :to_user              => message.to_user,
            :from_user            => message.from_user,
            :original_id          => message.id,
            :from_user_id         => message.from_user_id,
            :profile_image_url    => message.profile_image_url,
            :original_created_at  => message.created_at,
            :created_at           => Time.now
          )
        end
      end
    end
  end
end