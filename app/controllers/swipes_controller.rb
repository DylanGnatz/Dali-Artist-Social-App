class SwipesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  def index
    @profile = Profile.find_by(user_id: current_user.id)
    @already_swiped = Swipe.where(profile_id: @profile.id).pluck(:swiped_id)
    @already_swiped.push(@profile.id)
    @potential_match = Profile.where.not(id: @already_swiped).order("RANDOM()").first
    puts 'match'
    puts @potential_match
  end

  def create
    swiped_id = params[:profile_id]
    interested = params[:interested]
    @profile = Profile.find_by(user_id: current_user.id)
    @swipe = Swipe.create!(:profile_id => @profile.id, :swiped_id => swiped_id, :interested => interested, :swipe_time => Time.now())
    @check_match = match(@profile.id, swiped_id)

    if @check_match
      flash[:notice] = "You just matched with '#{params[:username]}!'"
    end
    redirect_to swipes_path

  end

  def match(swiper_id, swiped_id)

    swipe_1 = Swipe.find_by(profile_id: swiper_id, swiped_id: swiped_id)
    swipe_2 = Swipe.find_by(profile_id: swiped_id, swiped_id: swiper_id)
    if swipe_1 and swipe_2

      if swipe_1.interested and swipe_2.interested
        Friend.create(profile_id: swiper_id,friend_id: swiped_id, created_at: Time.now(), updated_at: Time.now())
        Friend.create(profile_id: swiped_id,friend_id: swiper_id, created_at: Time.now(), updated_at: Time.now())
        return true
      end
    end
    return false
  end
end