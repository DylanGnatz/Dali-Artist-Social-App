class SwipesController < ApplicationController
  before_action :authenticate_user!
  def index

    @profile = Profile.find_by(user_id: current_user.id)
    already_swiped = Swipe.where(profile_id: @profile.id).pluck(:swiped_id)
    already_swiped.push(@profile.id)
    @potential_match = Profile.near([@profile.lat, @profile.lng], 50).where.not(id: already_swiped).order("RANDOM()").first
    #@potential_match = Profile.where.not(id: @already_swiped).order("RANDOM()").first
    @geocoder = @profile.get_geocoder_data
    if @potential_match
      @distance = Geocoder::Calculations.distance_between([@profile.lat, @profile.lng], [@potential_match.lat, @potential_match.lng])
      # puts @distance
    end
  end

  def create
    swiped_id = params[:profile_id]
    interested = params[:interested]
    @profile = Profile.find_by(user_id: current_user.id)
    @swipe = Swipe.create!(:profile_id => @profile.id, :swiped_id => swiped_id, :interested => interested, :swipe_time => Time.now())

    @check_match = Swipe.match(@profile.id, swiped_id)



    if @check_match
      flash[:notice] = "You just matched with '#{params[:username]}'!"
    end
    redirect_to swipes_path

  end



end