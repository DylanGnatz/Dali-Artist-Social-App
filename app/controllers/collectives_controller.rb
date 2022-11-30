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
        elsif params[:collective][:bio] == ''
            flash[:alert] = "The collective must have a bio!"
            redirect_to new_collective_path
        elsif params[:members] == nil
            flash[:alert] = "The collective must have other members!"
            redirect_to new_collective_path
        else
            chat = Chat.create!()
            collective = Collective.create!(collective_params.merge({chat_id: chat.id}))
            if params[:main_photo] != nil
                collective.main_photo.attach(params[:main_photo])
            end
            CollectivesProfile.create!(collective_id: collective.id, profile_id: profile.id)
            params[:members].keys.each do |memberId|
                CollectivesProfile.create!(collective_id: collective.id, profile_id: memberId)
            end
            redirect_to collectives_path
        end
    end

    def new
        profile = Profile.find_by(user_id: current_user.id)
        @friends = profile.all_friends
    end

    def edit
        profile = Profile.find_by(user_id: current_user.id)
        @collective = profile.collectives.find_by_id(params[:id])
        if @collective == nil
            redirect_to collectives_path
            return
        end
        @addable_friends = profile.all_friends - @collective.profiles - [profile]
    end

    def update
        profile = Profile.find_by(user_id: current_user.id)
        collective = profile.collectives.find_by_id(params[:id])
        if collective == nil
            redirect_to collectives_path
            return
        end
        collective.update!(collective_params)
        collective.main_photo.attach(params[:main_photo])
        flash[:notice] = "Collective was successfully updated."
        redirect_to collectives_path
    end

    def destroy
        profile = Profile.find_by(user_id: current_user.id)
        collective = profile.collectives.find_by_id(params[:id])
        if collective == nil
            redirect_to collectives_path
            return
        end
        collective.destroy
        collective.chat.destroy
        flash[:notice] = "Collective was successfully deleted."
        redirect_to collectives_path
    end

    def show
        profile = Profile.find_by(user_id: current_user.id)
        @collective = profile.collectives.find_by_id(params[:id])
        if @collective == nil
            redirect_to collectives_path
            return
        end
    end

    private

    def collective_params
        params.require(:collective).permit(:bio, :name, :date_of_birth, :profile_photo)
    end

end
