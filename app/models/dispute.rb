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

	private

	def lower_case_name
		self.name = name.downcase
	end

end
