FactoryBot.define do
  factory :collective do
    sequence(:id) { |n| n }
    sequence(:name) { |n| "Group#{n}" }
  end
end
