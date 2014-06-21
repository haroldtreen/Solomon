require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource "Dispute" do
  
  SHOW_ATTRIBUTES = ['status', 'items']

  before(:all) do 
    @dispute = create(:dispute)
  end

  before(:each) { @dispute.reload }

  get "/api/disputes/:id" do
  	let(:id) { @dispute.id }

    example "Show a Dispute" do
      do_request

      expect(status).to eq(200)
      expect(json_response['dispute']['name']).to eq(@dispute.name.titleize)
      expect_response_matches_resource(json_response['dispute'], @dispute, SHOW_ATTRIBUTES)
    end
  end

  get "/api/disputes" do
    example "Get a dispute by name" do
      do_request(name: @dispute.name)

      expect(status).to eq(200)
      expect(json_response['dispute']['name']).to eq(@dispute.name.titleize)
      expect_response_matches_resource(json_response['dispute'], @dispute, SHOW_ATTRIBUTES)
    end

    example "Error: No dispute exists", document: false do
      do_request(name: @dispute.name + " fake")

      expect(status).to eq(404)
      expect(json_response['message']).to eq("Not Found!")
    end
  end

  post "/api/disputes" do
    example "Creating a dispute" do
      dispute = attributes_for(:dispute)

      expect{
        do_request(dispute: dispute)
      }.to change{ Dispute.count }

      expect(status).to be(201)
      expect(json_response['dispute']['name']).to eq(dispute[:name].titleize)
      expect_response_matches_resource(json_response['dispute'], dispute, SHOW_ATTRIBUTES)
    end
  end

  patch "/api/disputes/:id" do
    let(:id) { @dispute.id }

    example "Update a Dispute" do
      dispute = attributes_for(:dispute)

      do_request(dispute: dispute)

      expect(status).to be(202)
      expect(json_response['dispute']['name']).to eq(dispute[:name].titleize)
      expect_response_matches_resource(json_response['dispute'], dispute, SHOW_ATTRIBUTES)
    end
  end
end