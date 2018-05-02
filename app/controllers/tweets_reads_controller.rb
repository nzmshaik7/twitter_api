class TweetsReadsController < ApplicationController


	require 'tweetstream'

	TweetStream.configure do |config|
		config.consumer_key        = "XPz6tAL9g1Lefe0rPoziaZRaE"
  		config.consumer_secret     = "V1W1pKKCNGEWGgEncbD1vtSpF6QMPhMTPXrD5lnzbegHVHXlK1"
  		config.oauth_token        = "3010372477-NE4iLxIHhhgy9t0m1eA1PzeKGyrqVs37GLx33y3"
  		config.oauth_token_secret = "3AoukgMBzOj6s1e8pBJJIfuHip84UTQK9PefsCJfuKhYL"
  		config.auth_method         = :oauth
	end

	@hashtag_name = "#FisP"	

	require 'bunny'
	connection = Bunny.new
	connection.start
	channel = connection.create_channel
	queue = channel.queue('twitter_queue')
	
	
	TweetStream::Client.new.track("#FisP") do |status|
  			channel.default_exchange.publish("#{status.user.name} &:split:& #{status.text}", routing_key: queue.name, persistent: true)
	end

	connection.close

end