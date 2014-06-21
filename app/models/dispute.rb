class Dispute < ActiveRecord::Base
	before_save :lower_case_name

	private

	def lower_case_name
		self.name = name.downcase
	end
end
