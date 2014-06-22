class Api::UsersController < ApiController

	def show
		@user = User.find(params[:id])
	end

	def create
		if @user = User.create(user_params)
			render :show, status: :created, location: api_users_path(@user)
		else
			render json: @user.errors, status: :unprocessable_entity
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			render :show, status: :accepted, location: api_users_path(@user)
		else
			render json: @user.errors, status: :unprocessable_entity
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :dispute_id, { items: [] })
	end
end