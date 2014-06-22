class Dispute < ActiveRecord::Base

	before_validation :lower_case_name

	validates :name, uniqueness: true


	private

	def lower_case_name
		self.name = name.downcase
	end
end
