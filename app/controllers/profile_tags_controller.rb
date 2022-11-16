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
      flash[:alert] = "Invalid Tag"
    end
    redirect_to profile_tags_path
  end

  def update
    @profile = Profile.find_by(user_id: current_user.id)
    @tag = Tag.find_by(id: params[:tag_id])
    if @tag
      ProfileTag.find_or_create_by(tag_id: @tag.id, profile_id: @profile.id)
    else
      flash[:alert] = "Invalid Tag"
    end
    redirect_to profiles_edit_path
  end

  def destroy
    profile = Profile.find_by(user_id: current_user.id)
    #tag_name = params[:tag_name]

    profile_tag = ProfileTag.find_by(profile_id: profile.id, tag_id: params[:id])
    if profile_tag
      profile_tag.destroy
    else
      flash[:alert] = "Invalid Tag"
    end
    redirect_to profiles_edit_path
  end
end