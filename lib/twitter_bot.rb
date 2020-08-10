class TwitterBot
  attr_accessor :handles  

  def initialize(handles)
    @handles = handles
  end

  def tweet(tweet, handle = '', client = nil)
    # Initialize twitter client
    client = twitter_login
    client.update(handle + ' ' + tweet)
  end
  
  def tweet_to_many(tweet, number_of_handles)
    client = twitter_login
    @handles.sample(number_of_handles).each { |hndl| tweet(tweet, hndl, client) }
  end
  
  def get_tweets_by(hashtag, number_of_recent_tweets)
    twitter_login.search("#"+hashtag, result_type: "recent").take(number_of_recent_tweets)
  end
  
  def like_(hashtag, number_of_recent_tweets)
    twitter_login.favorite(get_tweets_by(hashtag, number_of_recent_tweets))
  end
  
  def follow_user_(hashtag, number_of_recent_tweets)
    begin
      get_tweets_by(hashtag, number_of_recent_tweets)
      .each { |tweet|
      if tweet.user.screen_name != 'wazo56146671'
        puts tweet.user.screen_name
        twitter_login.follow(tweet.user)
        twitter_login.update("@#{tweet.user.screen_name} Hi, my name is Wazo, i'am a Twitter bot, my master designed me during his training in web development. He says #bonjour_monde. @the_hacking_pro.") 
      end
      }
    rescue Twitter::Error::TooManyRequests => error
      # NOTE: Your process could go to sleep for up to 15 minutes but if you
      # retry any sooner, it will almost certainly fail with the same exception.
      sleep error.rate_limit.reset_in + 1
    retry
    end
  end

  private

  def display_credencial
    Dotenv.load('.env')
    puts ENV["TWITTER_CONSUMER_KEY"]
  end
  
  def twitter_login
    # n'oublie pas les lignes pour Dotenv ici…
    Dotenv.load('.env')
    
    # quelques lignes qui appellent les clés d'API de ton fichier .env
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end
end