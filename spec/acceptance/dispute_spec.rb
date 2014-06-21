require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource "Dispute" do
	before(:all) do 
		@dispute = create(:dispute)
	end

  get "/api/disputes/:id" do
  	let(:id) { @dispute.id }

    example "Listing disputes" do
      do_request

      response = json_response['dispute']

      expect(status).to eq(200)
      expect(response['status']).to eq(@dispute.status)
      expect(response['name']).to eq(@dispute.name)
      expect(response['items']).to eq(@dispute.items)
    end
  end
end