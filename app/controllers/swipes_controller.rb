class SwipesController < ApplicationController
  def index
    @potential_match = Profile.find(Profile.ids.sample)
  end

  def create
    @swipe = Swipe.create!(swipe_params)
  end
end