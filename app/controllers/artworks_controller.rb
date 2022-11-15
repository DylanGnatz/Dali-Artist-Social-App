class ArtworksController < ApplicationController
    before_action :authenticate_user!

    def create
        new_art = Artwork.create!(art_params.merge({profile: current_user.profile}))
        new_art.art_image.attach(params[:art_image])
        new_art.save
        flash[:notice] = "'#{art_params[:title]}' was successfully created."
        redirect_to profiles_index_path
    end

    def destroy
      Artwork.find(params[:id]).destroy
      flash[:notice] = "Artwork was successfully destroyed."
      redirect_to profiles_edit_path
    end

    private
    def art_params
      params.require(:artwork).permit(:title, :link, :onPortfolio, :addedDate, :type, :description, :isPrivate, :priority, :art_image)
    end

end