class CollectiveArtworksController < ApplicationController
    before_action :authenticate_user!

    def new
        @collective_id = params[:id]
        render :new
    end

    def create
        new_art = CollectiveArtwork.create!(art_params.merge({collective_id: params[:collective_id]}))
        new_art.art_image.attach(params[:art_image])
        new_art.save
        flash[:notice] = "'#{art_params[:title]}' was successfully added."
        redirect_to collective_path(id: params[:collective_id])
    end

    def destroy
      CollectiveArtwork.find(params[:artId]).destroy
      flash[:notice] = "Artwork was successfully deleted."
      redirect_to edit_collective_path(params[:id])
    end

    private
    def art_params
      params.require(:artwork).permit(:title, :link, :type, :description, :art_image)
    end

end