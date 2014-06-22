# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	name { "User #{Random.rand(100)}"}
  	dispute_id { create(:dispute).id }
  	items { Dispute.find(dispute_id).items }
  end
end
