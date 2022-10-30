class SwipesController < ApplicationController
  before_action :authenticate_user!
  def index
    #@profile = Profile.find_by(user_id: current_user.id)
    #@potential_match = Profile.where.not(id: current_user.id).order('RANDOM()').limit(1)
    @potential_match = Profile.where.not(id: current_user.id).order("RANDOM()").first
    print 'match id'
    print @potential_match.id
  end

  def create
    profile_id = params[:profile_id]
    interested = params[:interested]

    @swipe = Swipe.create!(current_user.id, profile_id, Time.now(), interested)
    redirect_to swipes_path

  end
end