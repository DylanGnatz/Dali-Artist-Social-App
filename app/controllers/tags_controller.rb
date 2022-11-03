class TagsController < ApplicationController
    before_action :authenticate_user!
    def index
        @profile = Profile.find_by(user_id: current_user.id)
    end
end

    