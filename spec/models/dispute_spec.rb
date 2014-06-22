require 'spec_helper'

describe Dispute do

	it 'saves names downcased' do 
		dispute = create(:dispute, name: "FOO")
		expect(dispute.name).to eq('foo')
	end

	it 'validates uniqueness of name' do
		uniq_dispute = create(:dispute, name: "Dispute 1")
		dup_dispute = build(:dispute, name: "Dispute 1")

		expect(dup_dispute).to_not be_valid
	end
end
