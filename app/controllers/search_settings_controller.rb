class SearchSettingsController < ApplicationController
  before_action :authenticate_user!
  def index
    @profile = Profile.find_by(user_id: current_user.id)
    @search_setting = @profile.search_setting
  end

  def update
    @search_setting = Profile.find_by(user_id: current_user.id).search_setting
    @search_setting.update!(params)

    flash[:notice] = "Profile was successfully updated."
    redirect_to search_settings_path
  end
end
