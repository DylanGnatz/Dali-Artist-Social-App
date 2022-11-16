class ChatsController < ApplicationController
    before_action :authenticate_user!

    def index
        profile = Profile.find_by(user_id: current_user.id)
        @chats = []
        @collective_chats = []
        profile.chats.each do |chat|
            if chat.profiles.size == 2
                @chats.push({ name: (chat.profiles - [profile])[0].username, id: chat.id })
            end
        end

        profile.collectives.each do |collective|
            @collective_chats.push({ name: collective.name, id: collective.chat.id })
        end
    end

    def show
        @profile = Profile.find_by(user_id: current_user.id)
        @chat = @profile.chats.find_by_id(params[:id])

        if @chat == nil
            redirect_to chats_path
            return
        end

        if @chat.profiles.size == 2
            @name = (@chat.profiles - [@profile])[0].username
        else
            @profile.collectives.each do |collective|
                if collective.chat.id.to_i == params[:id].to_i
                    @name = collective.name
                    break
                end
            end
        end

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
