class ArtworksController < ApplicationController
    before_action :authenticate_user!

    def create
        Artwork.create!(art_params.merge({profile: current_user.profile}))
        flash[:notice] = "'#{art_params[:title]}' was successfully created."
        redirect_to profiles_index_path
    end

    private
    def art_params
      params.require(:artwork).permit(:title, :link, :onPortfolio, :addedDate, :type, :description, :isPrivate, :priority)
    end

end