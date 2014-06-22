class Api::UsersController < ApiController

	def create
		if @user = User.create(user_params)
			ap @user
			render :show, status: :created, location: api_users_path(@user)
		else
			render json: @user.errors, status: :unprocessable_entity
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :dispute_id, { items: [] })
	end
end