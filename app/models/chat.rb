class Chat < ApplicationRecord
    has_and_belongs_to_many :profiles, through: :chats_profiles
    has_many:chats_messages
end
