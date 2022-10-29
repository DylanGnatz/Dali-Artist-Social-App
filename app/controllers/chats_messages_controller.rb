class ChatsMessagesController < ApplicationController
    def create
        msg = ChatsMessage.create!(chat_id: params[:chat_id], profile_id: params[:profile_id], msg: params[:chats_message][:msg])
        msg.save!
        redirect_to chat_path(params[:chat_id])
    end
end
