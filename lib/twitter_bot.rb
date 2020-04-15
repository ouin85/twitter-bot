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

def tweet(tweet)
  client = twitter_login
  # ligne qui permet de tweeter sur ton compte
  client.update(tweet)
end