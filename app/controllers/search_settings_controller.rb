class SearchSettingsController < ApplicationController
  before_action :authenticate_user!
  def index
    @profile = Profile.find_by(user_id: current_user.id)
    @search_setting = @profile.search_setting
  end

  def update
    @search_setting = Profile.find_by(user_id: current_user.id).search_setting
    @search_setting.update!(search_radius: params[:search_radius], gender_restrict: params[:gender_restrict], tag_restrict: params[:tag_restrict], show_profiles: params[:show_profiles], show_events: params[:show_events], show_collectives: params[:show_collectives])

    flash[:notice] = "Profile was successfully updated."
    redirect_to search_settings_path
  end
end
