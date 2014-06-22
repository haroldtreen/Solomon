require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource "Dispute" do
  before(:all) do 
    @dispute = create(:dispute)
    @show_attributes = ['status', 'items']
  end

  before(:each) { @dispute.reload }

  get "/api/disputes/:id" do
  	let(:id) { @dispute.id }

    example "Show a Dispute" do
      do_request

      expect(status).to eq(200)
      expect(json_response['dispute']['name']).to eq(@dispute.name.titleize)
      expect_response_matches_resource(json_response['dispute'], @dispute, @show_attributes)
    end
  end

  get "/api/disputes" do
    example "Get a dispute by name" do
      do_request(name: @dispute.name)

      expect(status).to eq(200)
      expect(json_response['dispute']['name']).to eq(@dispute.name.titleize)
      expect_response_matches_resource(json_response['dispute'], @dispute, @show_attributes)
    end

    example "Error: No dispute exists", document: false do
      do_request(name: @dispute.name + " fake")

      expect(status).to eq(404)
      expect(json_response['message']).to eq("Not Found!")
    end
  end

  get "/api/disputes/:id/results" do
    let(:id) { @dispute.id }

    example "Getting a disputes results" do
      create(:user, dispute_id: @dispute.id)
      create(:user, dispute_id: @dispute.id)

      do_request

      response_items = json_response['results']['user_1'] +
                       json_response['results']['user_2'] +
                       json_response['results']['contended'] 

      expect(status).to eq(200)
      expect(response_items.sort).to eq(@dispute.items.sort)
    end

    example "Error: Getting an incomplete dispute" do
      User.where(dispute_id: @dispute.id).destroy_all
      create(:user, dispute_id: @dispute.id)

      do_request

      expect(status).to be(422)
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
      expect_response_matches_resource(json_response['dispute'], dispute, @show_attributes)
    end
  end

  patch "/api/disputes/:id" do
    let(:id) { @dispute.id }

    example "Update a Dispute" do
      dispute = attributes_for(:dispute)

      do_request(dispute: dispute)

      expect(status).to be(202)
      expect(json_response['dispute']['name']).to eq(dispute[:name].titleize)
      expect_response_matches_resource(json_response['dispute'], dispute, @show_attributes)
    end
  end
end