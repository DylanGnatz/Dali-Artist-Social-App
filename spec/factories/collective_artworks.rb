FactoryBot.define do
  factory :collective_artwork do
    collective { nil }
    type { "" }
    title { "MyString" }
    description { "MyString" }
    onCollective { false }
    isPrivate { false }
    link { "MyString" }
  end
end
