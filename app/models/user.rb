class User < ActiveRecord::Base
	belongs_to :dispute

	validate :dispute_id, presence: true
	validate :items_match_dispute_items

	private

	def items_match_dispute_items
		errors.add(:items, "User is missing items!") if (dispute.items - items).any?
	end

end
