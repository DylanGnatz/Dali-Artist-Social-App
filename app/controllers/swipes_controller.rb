class SwipesController < ApplicationController
  before_action :authenticate_user!
  def index
    @profile = Profile.find_by(user_id: current_user.id)
    @already_swiped = Swipe.where(profile_id: @profile.id).pluck(:swiped_id)
    @already_swiped.push(@profile.id)
    @potential_match = Profile.where.not(id: @already_swiped).order("RANDOM()").first

  end

  def create
    swiped_id = params[:profile_id]
    interested = params[:interested]
    @profile = Profile.find_by(user_id: current_user.id)
    @swipe = Swipe.create!(:profile_id => @profile.id, :swiped_id => swiped_id, :interested => interested, :swipe_time => Time.now())
    @check_match = self.match(@profile.id, swiped_id)

    if @check_match
      flash[:notice] = "You just matched with '#{params[:username]}'!"
    end
    redirect_to swipes_path

  end

  def self.match(swiper_id, swiped_id)

    swipe_1 = Swipe.find_by(profile_id: swiper_id, swiped_id: swiped_id)
    swipe_2 = Swipe.find_by(profile_id: swiped_id, swiped_id: swiper_id)
    if swipe_1 and swipe_2

      if swipe_1.interested and swipe_2.interested
        Friend.create(profile_id: swiper_id,friend_id: swiped_id)
        return true
      end
    end
    return false
  end
end