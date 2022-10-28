class ProfilesController < ApplicationController
  def index
  end

  private

   def profile_params
      params.require(:user, :username)
   end
end
