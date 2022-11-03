FactoryBot.define do
    factory :profile do
        sequence(:id) { |n| Time.now() + n }
        sequence(:username) { |n| "user#{n}" }
        bio {"test man bio"}
        user { association :user, profile: instance }
    end
end
