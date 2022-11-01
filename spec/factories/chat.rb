FactoryBot.define do
    factory :chat do
        sequence(:id) { |n| n }
    end

    factory :chats_message do
        sequence(:id) { |n| n }
        msg { "msg" }
        profile
        chat
    end
end