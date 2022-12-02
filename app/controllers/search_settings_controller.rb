class SearchSettingsController < ApplicationController
  before_action :authenticate_user!
  def index
    @profile = Profile.find_by(user_id: current_user.id)
    @search_setting = @profile.search_setting
  end
end
