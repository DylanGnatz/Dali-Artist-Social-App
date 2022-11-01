class ChatsController < ApplicationController
    before_action :authenticate_user!

    def index
        profile = Profile.find_by(user_id: current_user.id)
        @chats = []
        profile.chats.each do |chat|
            @chats.push({ name: (chat.profiles - [profile])[0].username, id: chat.id })
        end
    end

    def show
        @chat = Chat.find(params[:id])
        @profile = Profile.find_by(user_id: current_user.id)

        @messages = []
        @chat.chats_messages.each do |chat_message|
            @messages.push({ msg: chat_message[:msg], from_profile: @profile.id == chat_message.profile.id, sender: chat_message.profile.username })
        end
    end

    def create
        profile = Profile.find_by(user_id: current_user.id)
        friend = Profile.find_by_username(params[:username])

        profile.chats.each do |chat|
            chat.profiles.each do |prof|
                if prof.username == friend.username
                    redirect_to chat_path(chat[:id])
                    return
                end
            end
        end

        chat = Chat.create!()
        ChatsProfile.create!(chat_id: chat.id, profile_id: profile.id)
        ChatsProfile.create!(chat_id: chat.id, profile_id: friend.id)
        redirect_to chat_path(chat[:id])
    end
end
