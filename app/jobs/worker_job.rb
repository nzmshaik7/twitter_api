class WorkerJob < ApplicationJob
	queue_as :default

	def perform()
		tweet_writes
	end
	
	def tweet_writes
		require 'bunny'
		require 'tweet.rb'

		connection = Bunny.new
		connection.start
		channel = connection.create_channel
		queue = channel.queue('twitter_queue')
	
		begin
  			
  			queue.subscribe(block: true) do |_delivery_info, _properties, body|
				arr = Array.new
				arr = "#{body}".split(" &:split:& ")
				tweet = Tweet.new(:username => arr[0], :message_body => arr[1])
				tweet.save()
			
       			end
		end
		
		rescue Interrupt => _
  			connection.close

  		exit(0)


	end
	handle_asynchronously :perform

end