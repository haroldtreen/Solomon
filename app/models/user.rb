class User < ActiveRecord::Base
	belongs_to :dispute

	validates :dispute_id, presence: true
	validates :name, uniqueness: { scope: :dispute_id }

	validate :items_match_dispute_items

	private

	def items_match_dispute_items
		errors.add(:items, "User is missing items!") if (dispute.items - items).any?
	end
end
