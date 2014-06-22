# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
  	name { "User #{Random.rand(100)}"}
  	dispute_id Random.rand(10)
  	items { ["cat", "rat", "bat"] }
  end
end
