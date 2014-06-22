# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :dispute do
  	name { "Name #{Random.rand(1000)}" }
  	items { ["cat", "hat", "mat"] }
  end
end
