class ProfileTagsController < ApplicationController
  before_action :authenticate_user!

  def index
    profile = Profile.find_by(user_id: current_user.id)
    profile_tag_ids = ProfileTag.find_by(profile_id: profile.id)
    @profile_tags = Tag.where(profile_tag_ids)
    @all_tags = Tag.all.order('tag_name')
  end

  def create
    profile = Profile.find_by(user_id: current_user.id)
    tag_name = params[:tag_name]
    tag = Tag.find_by(tag_name: tag_name)
    if tag
      ProfileTag.create!(profile_id: profile.id, tag_id: tag.id)
    else
      flash[:notice] = "Invalid Tag"
    end
    redirect_to profile_tags_path
  end

  def destroy
    profile = Profile.find_by(user_id: current_user.id)
    tag_name = params[:tag_name]
    tag = Tag.find_by(tag_name: tag_name)
    profile_tag = ProfileTag.find_by(profile_id: profile.id, tag_id: tag.id)
    if profile_tag
      ProfileTag.destroy
    else
      flash[:notice] = "Invalid Tag"
    end
    redirect_to profile_tags_path
  end
end