require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource "Users" do
  
  before(:all) do
  	@user = create(:user)
	  @show_attributes = ['name', 'items', 'dispute_id']
  end

  before(:each) { @user.reload }

  post "/api/users" do
  	example 'Creating a User' do
	  	user = attributes_for(:user)

	  	do_request(user: user)

	  	expect(status).to be(201)
	    expect_response_matches_resource(json_response['user'], user, @show_attributes)
	  end
	end
end