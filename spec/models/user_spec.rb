require 'spec_helper'

describe User do

	let(:user) { build(:user) }

	it { expect(user).to respond_to(:dispute) }

	it 'should have the same items as its dispute' do
		dispute = create(:dispute, items: ['a', 'b', 'c'])
		incomplete_user = build(:user, dispute_id: dispute.id, items: ['x', 'y', 'z'])

		expect(incomplete_user).to_not be_valid
	end

	it 'should have a unique name for the dispute' do
		dispute = create(:dispute)
		user_1 = create(:user, name: "Foo", dispute_id: dispute.id)
		expect(build(:user, name: "Foo", dispute_id: dispute.id)).to_not be_valid
	end
end
