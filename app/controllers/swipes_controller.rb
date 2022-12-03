class SwipesController < ApplicationController
  before_action :authenticate_user!
  def index

    @profile = Profile.find_by(user_id: current_user.id)
    unless @profile.search_setting
      @profile.search_setting = SearchSetting.create(search_radius: 50, gender_restrict: false, tag_restrict: false, show_events: true, show_profiles: true, show_collectives: true)
    end
    #already_swiped = Swipe.where(profile_id: @profile.id).pluck(:swiped_id)
    #already_swiped.push(@profile.id)
    #@potential_match = Profile.near([@profile.lat, @profile.lng], @profile.search_setting.search_radius).where.not(id: already_swiped).order("RANDOM()").first
    @potential_match = @profile.match_queue
    #@potential_match = Profile.where.not(id: @already_swiped).order("RANDOM()").first
    @geocoder = @profile.get_geocoder_data
    if @potential_match.instance_of?(Profile)
      @distance = Geocoder::Calculations.distance_between([@profile.lat, @profile.lng], [@potential_match.lat, @potential_match.lng]).round(2)
      # puts @distance
    end
  end

  def create
    swiped_id = params[:profile_id]
    interested = params[:interested]
    @profile = Profile.find_by(user_id: current_user.id)
    if params[:class] == 'Profile'
      @swipe = Swipe.create!(:profile_id => @profile.id, :swiped_id => swiped_id, :interested => interested, :swipe_time => Time.now())
      @check_match = Swipe.match(@profile.id, swiped_id)
    elsif params[:class] == 'Event'
      @swipe = Swipe.create!(:profile_id => @profile.id, :event_id => swiped_id, :interested => interested, :swipe_time => Time.now())
    elsif params[:class] == 'Collective'
      @swipe = Swipe.create!(:profile_id => @profile.id, :collective_id => swiped_id, :interested => interested, :swipe_time => Time.now())
    end


    if @check_match
      username = Profile.where(id: swiped_id).pluck(:username)
      flash[:notice] = "You just matched with '#{username}'!"
    end
    redirect_to swipes_path

  end



end