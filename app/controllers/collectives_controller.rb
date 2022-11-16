class CollectivesController < ApplicationController
    before_action :authenticate_user!

    def index
        profile = Profile.find_by(user_id: current_user.id)
        @collectives = profile.collectives
    end

    def create
        profile = Profile.find_by(user_id: current_user.id)
        if params[:collective][:name] == ''
            flash[:alert] = "The collective must have a name!"
            redirect_to new_collective_path
        elsif params[:members] == nil
            flash[:alert] = "The collective must have other members!"
            redirect_to new_collective_path
        else
            chat = Chat.create!()
            collective = Collective.create!(name: params[:collective][:name], chat_id: chat.id)
            CollectivesProfile.create!(collective_id: collective.id, profile_id: profile.id)
            ChatsProfile.create!(chat_id: chat.id, profile_id: profile.id)
            params[:members].keys.each do |memberId|
                CollectivesProfile.create!(collective_id: collective.id, profile_id: memberId)
                ChatsProfile.create!(chat_id: chat.id, profile_id: memberId)
            end
            redirect_to collectives_path
        end
    end

    def new
        profile = Profile.find_by(user_id: current_user.id)
        @friends = profile.all_friends
    end

    def show
        profile = Profile.find_by(user_id: current_user.id)
        @collective = profile.collectives.find_by_id(params[:id])
        if @collective == nil
            redirect_to collectives_path
            return
        end
    end

end
