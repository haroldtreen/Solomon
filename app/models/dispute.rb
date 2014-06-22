class Dispute < ActiveRecord::Base
	has_many :users

	before_validation :lower_case_name

	validates :name, uniqueness: true

	def results
		if users.count >= 2
			user_1 = users.first
			user_2 = users.last

			splitter = ComplexSplit.new(preferences_a: user_1.items, preferences_b: user_2.items)
			results = splitter.results

			{ 
				items_1: results[:preferences_a], name_1: user_1.name,
				items_2: results[:preferences_b], name_2: user_2.name, 
				contested: results[:contested] 
			}
		else
			nil
		end
	end

	def status
		if users.count < 1
			"unstarted"
		elsif users.count == 1
			"started"
		else
			update_twitter
			"finished"
		end
	end

	private

	def lower_case_name
		self.name = name.downcase
	end

	def update_twitter
		unless is_tweeted
			tweeter = SplitTweeter.new()
			tweeter.tweet_dispute(self)
		end
	end
end
