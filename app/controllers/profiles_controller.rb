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

  def show
    id = params[:id]
    @profile = Profile.find(id)
  end
  
  def feed
    profile = Profile.find_by(user_id: current_user.id)
    @feed_items = []
    profile.all_friends.each do |friend|
      friend.artworks.each do |artwork|
        @feed_items.push artwork
      end
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:bio, :username, :date_of_birth)
  end
end
