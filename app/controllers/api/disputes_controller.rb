class Api::DisputesController < ApiController

	def show
		@dispute = Dispute.find(params[:id])
	end

end