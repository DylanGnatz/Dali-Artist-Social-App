class ChatsController < ApplicationController
    before_action :authenticate_user!

    def index
        profile = Profile.find_by(user_id: current_user.id)
        @chats = []
        @collective_chats = []
        profile.chats.each do |chat|
            @chats.push({ name: (chat.profiles - [profile])[0].username, id: chat.id })
        end

        profile.collectives.each do |collective|
            @collective_chats.push({ name: collective.name, id: collective.chat.id })
        end
    end

    def show
        @profile = Profile.find_by(user_id: current_user.id)
        @isCollective = false
        if @profile.chats.find_by_id(params[:id]) != nil
            @chat = @profile.chats.find_by_id(params[:id])
            @name = (@chat.profiles - [@profile])[0].username
        elsif
            @collective = @profile.collectives.find_by_chat_id(params[:id])
            @chat = @collective.chat
            @name = @collective.name
            @isCollective = true
        end

        if @chat == nil
            redirect_to chats_path
            return
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

    def destroy
        chat = Chat.find(params[:id])
        chat.destroy
        flash[:notice] = "Chat was successfully deleted."
        redirect_to chats_path
    end
end
