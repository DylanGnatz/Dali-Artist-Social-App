require 'rails_helper'

describe SwipesController do
  login_user

  before :each do
    @profile1 = @user.profile
    @profile2 = create(:user).profile
    @profile3 = create(:user).profile
    
  end

  describe "#create" do
    it "creates a new match record" do
      @swipe = Swipe.create(profile_id: @profile1.id, swiped_id: @profile2.id, interested: true, swipe_time: Time.now())
      @swipe.should be_an_instance_of Swipe
    end
  end
end
