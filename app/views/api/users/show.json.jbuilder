json.user do
	json.(@user, :id, :items, :dispute_id)
	json.name @user.name.titleize
end