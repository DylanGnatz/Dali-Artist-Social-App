FactoryBot.define do
    factory :friend do
        sequence(:id) { |n| n }
        profile { association :profile, friend: instance }
    end
end
