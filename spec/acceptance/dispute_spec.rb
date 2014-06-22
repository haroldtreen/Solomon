require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource "Dispute" do
  before(:all) do 
    @dispute = create(:dispute)
    @user_1 = create(:user, dispute_id: @dispute.id)
    @user_2 = create(:user, dispute_id: @dispute.id)

    @show_attributes = ['items']
  end

  before(:each) { @dispute.reload }

  get "/api/disputes/:id" do
  	let(:id) { @dispute.id }

    example "Show a Dispute" do
      do_request

      results = json_response['dispute']['results']

      expect(status).to eq(200)
      expect(json_response['dispute']['name']).to eq(@dispute.name.titleize)
      expect(results['name_1']).to eq(@user_1.name)
      expect(results['contested']).to eq(@user_1.items) 
      expect(json_response['dispute']['status']).to eq("finished")
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
      do_request

      response_items = json_response['results']['items_1'] +
                       json_response['results']['items_2'] +
                       json_response['results']['contested']

      expect(status).to eq(200)
      expect(json_response['results']['name_1']).to eq(@user_1.name)
      expect(json_response['results']['name_2']).to eq(@user_2.name)
      expect(response_items.sort).to eq(@dispute.items.sort)
    end

    example "Error: Getting an incomplete dispute", document: false do
      User.where(dispute_id: @dispute.id).destroy_all
      create(:user, dispute_id: @dispute.id)

      do_request

      expect(status).to be(422)
    end

    example "Error: Getting a non-existent dispute", document: false do
      previous_id = @dispute.id
      @dispute.id = 1000000

      do_request
      expect(status).to be(404)

      @dispute.id = previous_id
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