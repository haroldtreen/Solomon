def json_response
	@json ||= JSON.parse response_body
end

def expect_response_matches_resource(response, resource, attrs)
	attrs.each do |attribute|
		expect(response[attribute.to_s]).to eq(resource[attribute.to_sym])
	end
end