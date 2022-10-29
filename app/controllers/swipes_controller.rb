class SwipesController < ApplicationController
  def index
    if current_user
      @user = current_user
    else
      redirect_to new_user_session_path, notice: 'You are not logged in.'
    end
    @potential_match = Profile.find(Profile.ids.sample)
  end

  def create
    user_id = @user.id
    match_id = @potential_match.id

    @swipe = Swipe.create!()
  end
end