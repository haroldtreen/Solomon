require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource "Dispute" do
  
  SHOW_ATTRIBUTES = ['status', 'name', 'items']

  before(:all) do 
    @dispute = create(:dispute)

  end

  get "/api/disputes/:id" do
  	let(:id) { @dispute.id }

    example "Show a Dispute" do
      @dispute.reload

      do_request

      response = json_response['dispute']

      expect(status).to eq(200)
      expect_response_matches_resource(response, @dispute, SHOW_ATTRIBUTES)
    end
  end

  get "/api/disputes" do
    example "Get a dispute by name" do

    end
  end

  post "/api/disputes" do
    example "Creating a dispute" do
      dispute = attributes_for(:dispute)

      expect{
        do_request(dispute: dispute)
      }.to change{ Dispute.count }

      response = json_response['dispute']

      expect(status).to be(201)
      expect(response['status']).to eq(dispute[:status])
      expect(response['name']).to eq(dispute[:name])
      expect(response['items']).to eq(dispute[:items])
    end
  end

  patch "/api/disputes/:id" do
    let(:id) { @dispute.id }

    example "Update a Dispute" do
      dispute = attributes_for(:dispute)

      do_request(dispute: dispute)

      response = json_response['dispute']

      expect(status).to be(202)
      expect(response['status']).to eq(dispute[:status])
      expect(response['name']).to eq(dispute[:name])
      expect(response['items']).to eq(dispute[:items])
    end
  end
end