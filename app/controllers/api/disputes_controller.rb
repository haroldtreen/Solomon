class Api::DisputesController < ApiController

	def show
		@dispute = Dispute.find(params[:id])
	end

	def find_by_name
		@dispute = Dispute.find_by!(name: params[:name].downcase)
		render :show
	end

	def create
		@dispute = Dispute.create(dispute_params)
		render :show, status: :created, location: api_dispute_path(@dispute)
	end

	def update
		@dispute = Dispute.find(params[:id])
		@dispute.update(dispute_params)
		render :show, status: :accepted, location: api_dispute_path(@dispute)
	end

	private

	def dispute_params
		params.require(:dispute).permit(:name, { items: [] }, :status)
	end

end