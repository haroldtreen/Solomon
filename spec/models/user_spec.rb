require 'spec_helper'

describe User do

	let(:user) { build(:user) }

	it { expect(user).to respond_to(:dispute) }

	it 'should have the same items as its dispute' do
		dispute = create(:dispute, items: ['a', 'b', 'c'])
		incomplete_user = build(:user, dispute_id: dispute.id, items: ['x', 'y', 'z'])

		expect(incomplete_user).to_not be_valid
	end
end
