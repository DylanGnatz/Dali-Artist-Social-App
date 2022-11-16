class ProfileTagsController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def create

  end

  def update
    profile = Profile.find_by(user_id: current_user.id)
    puts("#######################")
    puts(params)
    tag = Tag.find_by(id: params[:id])
    if tag and not profile.tags.exists?(id: params[:id])
      profile.tags << tag
    elsif tag
      flash[:alert] = "Profile already contains this tag"
    else
      flash[:alert] = "Invalid Tag"
    end
    redirect_to profiles_edit_path
  end

  def destroy
    profile = Profile.find_by(user_id: current_user.id)
    tag = Tag.find_by(id: params[:id])

    if tag
      profile.tags.delete(tag)
    else
      flash[:alert] = "Invalid Tag"
    end
    redirect_to profiles_edit_path
  end
end