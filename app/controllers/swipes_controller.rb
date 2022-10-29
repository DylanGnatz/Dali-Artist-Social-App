class SwipesController < ApplicationController
  def index:
    @profiles = Profile.all()
  end

  def new_swipe:
    @swipe = Swipe.create!(swipe_params)
  end
end