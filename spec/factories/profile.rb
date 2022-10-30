FactoryBot.define do
    factory :profile do
        sequence(:id) { |n| n }
        sequence(:username) { |n| "user#{n}" }
        bio {"test man bio"}
        user { association :user, profile: instance }
    end
end
