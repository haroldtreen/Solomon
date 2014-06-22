require 'spec_helper'

describe Dispute do

	it { expect(build(:dispute)).to respond_to(:users)}

	it 'saves names downcased' do 
		dispute = create(:dispute, name: "FOO")
		expect(dispute.name).to eq('foo')
	end

	it 'validates uniqueness of name' do
		uniq_dispute = create(:dispute, name: "Dispute 1")
		dup_dispute = build(:dispute, name: "Dispute 1")

		expect(dup_dispute).to_not be_valid
	end

	it 'computes results' do
		dispute = create(:dispute)
		user_1 = create(:user, dispute_id: dispute.id)
		user_2 = create(:user, dispute_id: dispute.id)

		results = dispute.results
		expect(results[:name_1]).to eq(user_1.name)
		expect(results[:name_2]).to eq(user_2.name)

		all_items = results[:items_1] + results[:items_2] + results[:contested]

		expect(all_items.sort).to eq(user_1.items.sort)
	end
end
