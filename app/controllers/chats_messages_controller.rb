class ChatsMessagesController < ApplicationController
    before_action :authenticate_user!

    def create
        profile = Profile.find_by(user_id: current_user.id)

        if params[:chats_message][:msg] == ''
            flash[:alert] = "The message was empty!"
        else
            msg = ChatsMessage.create!(chat_id: params[:chat_id], profile_id: profile.id, msg: params[:chats_message][:msg])
            msg.save!
        end
        redirect_to chat_path(params[:chat_id])
    end
end
