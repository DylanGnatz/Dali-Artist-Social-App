class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def index
    @profile = Profile.find_by(user_id: current_user.id)
  end
  def edit
    @profile = Profile.find_by(user_id: current_user.id)
    @available_tags = Tag.where.not(id: @profile.tags).order('name')
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
    #test
    @artwork = @profile.artworks.pick()
  end

  def location
    profile = Profile.find_by(user_id: current_user.id)
    if params["lat"] and params["lng"]
      profile.update(lat: params["lat"], lng: params["lng"])
    else
      profile.update(lat: request.location.latitude, lng: request.location.longitude)
    end
    redirect_to swipes_path
  end
  
  def feed
    profile = Profile.find_by(user_id: current_user.id)
    @feed_items = []
    profile.all_friends.each do |friend|
      friend.artworks.each do |artwork|
        @feed_items.push({type: :artwork, artwork: artwork, time: artwork.created_at})
      end
      friend.events.each do |event|
        @feed_items.push({type: :event, event: event, time: event.created_at})
      end
    end
    profile.collectives.each do |collective|
      collective.collective_artworks.each do |artwork|
        @feed_items.push({type: :collective_artwork, artwork: artwork, time: artwork.created_at})
      end
    end
    @feed_items.sort_by! { |item| item[:time]}.reverse!
  end

  private

  def profile_params
    params.require(:profile).permit(:bio, :username, :date_of_birth, :profile_photo)
  end
end
