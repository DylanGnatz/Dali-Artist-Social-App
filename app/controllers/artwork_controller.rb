class ArtworkController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @profile = Profile.find_by(user_id: current_user.id)
        #@artwork = profile.all_artwork
    end

    def create
        @artwork = Artwork.create!(art_params)
        flash[:notice] = "#{@artwork.title} was successfully created."
        redirect_to profiles_index_path
    end

    private

    def art_params
    # puts params
      params.require(:artwork).permit(:title, :link, :onPortfolio, :addedDate, :type, :description, :isPrivate, :priority)
    end

end