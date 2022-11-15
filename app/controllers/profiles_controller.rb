class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def index
    @profile = Profile.find_by(user_id: current_user.id)
  end
  def edit
    @profile = Profile.find_by(user_id: current_user.id)
    profile_tags = ProfileTag.where(profile_id: @profile.id).pluck(:tags_id)
    @tags = Tag.where(id: profile_tags)
    @available_tags = Tag.where.not(id: profile_tags).order('tag_name')
  end

  def update
    @profile = Profile.find_by(user_id: current_user.id)
    @profile.update!(profile_params)
    @profile.profile_photo.attach(params[:profile_photo])
    flash[:notice] = "Profile was successfully updated."
    redirect_to profiles_index_path
  end

  def show
    id = params[:id]
    @profile = Profile.find(id)
  end

  def location
    profile = Profile.find_by(user_id: current_user.id)
    profile.update(lat: params["lat"])
    profile.update(lng: params["lng"])
  end
  
  def feed
    profile = Profile.find_by(user_id: current_user.id)
    @feed_items = []
    profile.all_friends.each do |friend|
      friend.artworks.each do |artwork|
        @feed_items.push({type: :artwork, artwork: artwork})
      end
      friend.events.each do |event|
        @feed_items.push({type: :event, event: event})
      end
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:bio, :username, :date_of_birth)
    params.require(:profile).permit(:profile_photo)
  end
end
