FactoryBot.define do
  factory :collective do
    sequence(:name) { |n| "Group#{n}" }
  end
end
