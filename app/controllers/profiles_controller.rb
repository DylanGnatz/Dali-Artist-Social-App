class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def index
    @profile = Profile.find_by(user_id: current_user.id)
  end
  def edit
    @profile = Profile.find_by(user_id: current_user.id)
  end

  def update
    @profile = Profile.find_by(user_id: current_user.id)
    @profile.update!(profile_params)
    flash[:notice] = "Profile was successfully updated."
    redirect_to profiles_index_path
  end

  private

  def profile_params
  puts params
    params.require(:profile).permit(:bio, :username, :date_of_birth)
  end
end
