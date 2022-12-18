require 'rails_helper'

describe CollectivesProfilesController do
  login_user

  before :each do
    @profile1 = @user.profile
    @profile2 = create(:user).profile
    @profile3 = create(:user).profile
    @profile4 = create(:user).profile
    @profile5 = create(:user).profile
    @profile6 = create(:user).profile

    @chat1 = create(:chat, profiles: [@profile1, @profile2])
    @collective1 = create(:collective, profiles: [@profile1, @profile2], chat:@chat1)
    @profile1.collectives = [@collective1]
  end

  describe 'post add' do
    it 'adds defined members to a collective' do
        allow(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
        allow(Collective).to receive(:find_by_id).with(@collective1.id.to_s).and_return(@collective1)

        members = {}
        members[@profile3.id.to_i] = 1
        members[@profile4.id.to_i] = 1
        members[@profile5.id.to_i] = 1
        post :add, params: { id: @collective1.id, members: members }
        expect(response).to redirect_to(edit_collective_path(@collective1.id.to_s))
    end
    it 'redirects when wrong colelctive id given' do
        allow(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
        allow(Collective).to receive(:find_by_id).with("5").and_return(nil)

        members = {}
        members[@profile3.id.to_i] = 1
        members[@profile4.id.to_i] = 1
        members[@profile5.id.to_i] = 1
        post :add, params: { id: 5, members: members }
        expect(response).to redirect_to(collectives_path)
    end
  end

  describe 'delete' do
    it 'profile from the collective' do
        allow(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
        allow(Collective).to receive(:find_by_id).with(@collective1.id.to_s).and_return(@collective1)
        delete :destroy, params: { id: @collective1.id, memberId: @profile2.id }
        expect(response).to redirect_to(edit_collective_path(@collective1.id.to_s))
    end
    it 'redirects when wrong collective id given' do
        allow(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
        allow(Collective).to receive(:find_by_id).with("5").and_return(nil)

        delete :destroy, params: { id: "5", memberId: @profile2.id }
        expect(response).to redirect_to(collectives_path)
    end
  end
end