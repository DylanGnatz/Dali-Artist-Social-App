FactoryBot.define do
    factory :user do
      id {1}
      username {"test123"}
      email {"test@user.com"}
      password {"qwerty"}
      # Add additional fields as required via your User model
    end
end
