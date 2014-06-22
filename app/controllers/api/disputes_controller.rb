class Api::DisputesController < ApiController

	def show
		@dispute = Dispute.find(params[:id])
	end

	def find_by_name
		@dispute = Dispute.find_by!(name: params[:name].downcase)
		render :show
	end

	def create
		if @dispute = Dispute.create(dispute_params)
			render :show, status: :created, location: api_dispute_path(@dispute)
		else
			render json: @dispute.errors, status: :unprocessable_entity
		end
	end

	def update
		@dispute = Dispute.find(params[:id])
		if @dispute.update(dispute_params)
			render :show, status: :accepted, location: api_dispute_path(@dispute)
		else
			render json: @dispute.errors, status: :unprocessable_entity
		end
	end

	def results
		@dispute = Dispute.find(params[:id])
		users = User.where(dispute_id: @dispute.id).limit(2)

		if users.count >= 2
			render json: { results: { user_1: [], user_2: [], contended: @dispute.items}}
		else
			render json: { message: "Incomplete Dispute" }, status: :unprocessable_entity
		end
	end

	private

	def dispute_params
		params.require(:dispute).permit(:name, { items: [] }, :status)
	end
end