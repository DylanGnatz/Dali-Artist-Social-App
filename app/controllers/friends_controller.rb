class FriendsController < ApplicationController
    before_action :authenticate_user!
    def index
        profile = Profile.find_by(user_id: current_user.id)
        @friends = profile.all_friends
    end
end
