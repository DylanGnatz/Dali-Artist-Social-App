require 'rails_helper'

describe ProfileTagsController do
  login_user

  before :each do
    @profile1 = @user.profile
    @tag1 = Tag.create(name: 'Painting')
  end



  describe 'update tags' do
    it 'checks tag association' do
      @profile1.tags << @tag1
      @tag = @profile1.tags.first
      expect(@tag == @tag1)
    end
  end

  describe 'put update' do
    it 'new event page' do
      expect(Profile).to receive(:find_by).and_return(@profile)

      put :update, params: {profile: {id: 1}}
      expect(response).to redirect_to(profiles_edit_path)
    end
  end

  describe 'delete' do
    it 'remove tag' do
      expect(Profile).to receive(:find_by).and_return(@profile)
      @profile1.tags <<  @tag1
      delete :destroy, params: {id: 1}
      expect(response).to redirect_to(profiles_edit_path)
    end
  end
end



