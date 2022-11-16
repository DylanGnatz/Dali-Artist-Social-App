class TagsController < ApplicationController
    before_action :authenticate_user!
    def index
        @profile = Profile.find_by(user_id: current_user.id)
    end

    def update
        profile = Profile.find_by(user_id: current_user.id)
        tag = Tag.find_by(id: params[:id])
        if tag and not profile.tags.exists?(id: params[:id])
            profile.tags << tag
        elsif tag
            flash[:alert] = "Profile already contains this tag"
        else
            flash[:alert] = "Invalid Tag"
        end
        redirect_to profiles_edit_path
    end
end

    