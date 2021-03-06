require 'pry'
require 'dotenv'  # Appelle la gem Dotenv
require 'twitter' # ligne très importante qui appelle la gem
require_relative 'lib/twitter_bot'
require_relative 'lib/handles'

# --- Test Dotenv ---

def multiply_by_6(var) #définition d'une méthode multipliant par 6 en 2 étapes
  var = var * 2
  binding.pry # On lance PRY au milieu de la méthode
  var = var * 3
  return var
end

# multiply_by_6(5) # j'exécute la méthode sur la valeur 5

# --- Test dotenv ---

def display_env_contents
  Dotenv.load('.env') # Ceci appelle le fichier .env (situé dans le même dossier que celui d'où tu exécute app.rb)
  # et grâce à la gem Dotenv, on importe toutes les données enregistrées dans un hash ENV
  
  # Il est ensuite très facile d'appeler les données du hash ENV, par exemple là je vais afficher le contenu de la clé TWITTER_API_SECRET
  puts ENV['TWITTER_CONSUMER_KEY']
end

# display_env_contents

# --- Test Twitter ---
# puts display_credencial
# puts twitter_login
# tweet = 'Hi world! my name is Wazo I am a twitter robot. My master says hello! stay at home and take care of yourself and your loved ones. Everything will soon work out.'
# tweet(tweet)
# puts twitter_login.user("sferik")
# tweet = 'Hello my name is Wazo, I am a Twitter bot, my master designed me during his training in web development. He says #bonjour_monde and he thanks you for your efforts in this difficult period of coronavirus pandemic. @the_hacking_pro.'
# tweet_to_many(tweet, 2)
# p get_tweets_by('bonjour_monde', 25)
follow_user_('bonjour_monde', 20)
# twitter_login.follow(#<Twitter::User id=1250454251500945408>)
# puts twitter_login.user('wazo')
# twitter_login.follow("wazo")