require 'rails_helper'

describe SwipesController do
  login_user

  before :each do
    @profile1 = @user.profile

    @profile2 = create(:user).profile
    @profile3 = create(:user).profile
    
  end
  describe 'get index' do
    it 'shows all chats of a profile' do
      expect(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
      get :index
      expect(response).to be_successful
    end
  end

  describe 'post create' do
    it 'creates a new swipe record' do
      expect(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)

      @swipe = Swipe.create(profile_id: @profile1.id, swiped_id: @profile2.id, interested: true, swipe_time: Time.now())
      expect(Swipe).to receive(:create!).and_return(@swipe)


    end
  end
  describe "check match" do
    it "it checks if a match should be made" do
      @swipe = Swipe.create(profile_id: @profile1.id, swiped_id: @profile2.id, interested: true, swipe_time: Time.now())
      @swipe.should be_an_instance_of Swipe
      @swipe2 = Swipe.create(profile_id: @profile2.id, swiped_id: @profile1.id, interested: true, swipe_time: Time.now())
      @swipe2.should be_an_instance_of Swipe
      @matched = SwipesController.match(@profile1.id, @profile2.id)
      expect(@matched == true)
    end
  end
end
