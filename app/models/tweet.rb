class Tweet < ApplicationRecord
	
	def tweet_params
		params(require(:tweet).permit(:username, :message_body))
	end


	def self.search(search)
  		where("message_body LIKE ?", "%#{search}%") 
  	end
end
