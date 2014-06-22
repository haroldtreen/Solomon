class SplitTweeter
	def initialize()
		@client = Twitter::REST::Client.new do |config|
			config.consumer_key        = CONSUMER_KEY
		  config.consumer_secret     = CONSUMER_SECRET
		  config.access_token        = ACCESS_TOKEN
		  config.access_token_secret = ACCESS_TOKEN_SECRET
		end
	end

	def tweet_dispute(dispute)
		name_1 = dispute.users.first.name.humanize
		name_2 = dispute.users.last.name.humanize

		@client.update("#{name_1} & #{name_2} are consulting Solomon! See who gets what at: #{BASE_URL}/disputes/#{dispute.id}/results")

		dispute.update(is_tweeted: true)
	end
end
