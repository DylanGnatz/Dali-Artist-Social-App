FactoryBot.define do
    factory :user do
        sequence(:id) { |n| n }
        sequence(:username) { |n| "user#{n}" }
        sequence(:email) { |n| "user#{n}@test.com" }
        password {"qwerty"}
      # Add additional fields as required via your User model
    end
end
