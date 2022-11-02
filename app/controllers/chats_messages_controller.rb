class ChatsMessagesController < ApplicationController
    before_action :authenticate_user!

    def create
        profile = Profile.find_by(user_id: current_user.id)

        msg = ChatsMessage.create!(chat_id: params[:chat_id], profile_id: profile.id, msg: params[:chats_message][:msg])
        msg.save!
        redirect_to chat_path(params[:chat_id])
    end
end
