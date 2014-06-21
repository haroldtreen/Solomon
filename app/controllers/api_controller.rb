class ApiController < ApplicationController
	skip_before_filter :verify_authenticity_token

	respond_to :json


	rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { message: "Not Found!" }, status: :not_found
  end
end