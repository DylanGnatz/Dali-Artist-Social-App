require 'rails_helper'

describe TagsController do
  login_user

  before :each do
    @profile1 = @user.profile
    Tag.create(name: 'Painting')
    @tag1 = Tag.first
    #puts @tag1.inspect
    @profile1.tags << @tag1

  end



  describe 'update tags' do
    it 'checks tag association' do
      @tag = @profile1.tags.first
      expect(@tag == @tag1)
    end
  end

  describe 'put update' do
    it 'new event page' do
      expect(Profile).to receive(:find_by).and_return(@profile)

      put :update, params: {profile: {id: 1}}
      expect(response).to redirect_to(profiles_index_path)
    end
  end

end

