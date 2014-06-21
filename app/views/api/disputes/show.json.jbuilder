json.dispute do
	json.(@dispute, :id, :items, :status)
	json.name @dispute.name.titleize
end