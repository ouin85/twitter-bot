require 'pry'
require 'dotenv'
require 'twitter'

def display_credencial
  Dotenv.load('.env')
  ENV["TWITTER_CONSUMER_KEY"]
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

def tweet(client, tweet, handle = '')
  # binding.pry
  # ligne qui permet de tweeter sur ton compte
  client.update(handle + ' ' + tweet)
end

def tweet_to_many(tweet, number_of_handles)
  # number_of_handles.times {tweet(tweet, random_handle)}
  # A beautiful way
  client = twitter_login
  $handles.sample(number_of_handles).each { |hndl| tweet(client, tweet, hndl) }
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
    # binding.pry
    twitter_login.follow(tweet.user) unless tweet.user.screen_name == 'wazo56146671'
    puts tweet.user.screen_name
    # twitter_login.update("@#{tweet.user} Hi, my name is Wazo, i'am a Twitter bot") 
    }
  rescue Twitter::Error::TooManyRequests => error
    # NOTE: Your process could go to sleep for up to 15 minutes but if you
    # retry any sooner, it will almost certainly fail with the same exception.
    sleep error.rate_limit.reset_in + 1
  retry
  end
end