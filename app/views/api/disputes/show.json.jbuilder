json.dispute do
	json.(@dispute, :id, :items, :status)
	json.name @dispute.name.titleize
	json.results @dispute.results
	json.dispute_status @dispute.dispute_status
end
