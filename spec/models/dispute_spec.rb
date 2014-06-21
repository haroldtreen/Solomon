require 'spec_helper'

describe Dispute do

	it 'saves names downcased' do 
		dispute = create(:dispute, name: "FOO")
		expect(dispute.name).to eq('foo')
	end
end
