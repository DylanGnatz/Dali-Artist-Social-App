class CollectivesProfilesController < ApplicationController
    before_action :authenticate_user!

    def add
        profile = Profile.find_by(user_id: current_user.id)
        collective = profile.collectives.find_by_id(params[:id])
        if collective == nil
            redirect_to collectives_path
            return
        end
        params[:members].keys.each do |memberId|
            CollectivesProfile.create!(collective_id: collective.id, profile_id: memberId)
        end
        flash[:notice] = "Members were successfully added!"
        redirect_to edit_collective_path(params[:id])
    end

    def destroy
        profile = Profile.find_by(user_id: current_user.id)
        collective = profile.collectives.find_by_id(params[:id])
        if collective == nil
            redirect_to collectives_path
            return
        end
        collectiveP = CollectivesProfile.where('collective_id = ? and profile_id = ?', params[:id], params[:memberId])
        collectiveP[0].destroy
        flash[:notice] = "Member was successfully removed!"
        redirect_to edit_collective_path(params[:id])
    end
end