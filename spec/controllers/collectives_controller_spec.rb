require 'rails_helper'

describe CollectivesController do
  login_user

  before :each do
    @profile1 = @user.profile

    @profile2 = create(:user).profile
    @profile3 = create(:user).profile
    @profile4 = create(:user).profile
    @profile5 = create(:user).profile
    @profile6 = create(:user).profile

    @chat1 = create(:chat, profiles: [@profile1, @profile2, @profile3])
    @chat2 = create(:chat, profiles: [@profile1, @profile2, @profile4])
    @chat3 = create(:chat, profiles: [@profile3, @profile4, @profile5])

    @collective1 = create(:collective, profiles: [@profile1, @profile2, @profile3], chat:@chat1)
    @collective2 = create(:collective, profiles: [@profile1, @profile2, @profile4], chat:@chat2)
    @collective3 = create(:collective, profiles: [@profile3, @profile4, @profile5], chat:@chat3)

    @profile1.collectives = [@collective1, @collective2]
  end

  describe 'get index' do
    it 'shows all collectives of a profile' do
        expect(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
        get :index
        expect(response).to be_successful
    end

    it 'selects index template to render' do
        allow(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
        get :index
        expect(response).to render_template('index')
    end

    it 'makes the results available to that template' do
        allow(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
        get :index
        expect(assigns(:collectives)).to eq([@collective1, @collective2])
    end
  end

  describe 'show' do
    it 'get show shows a collective given id' do
        expect(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
        expect(Collective).to receive(:find_by_id).with(@collective1.id.to_s).and_return(@collective1)

        get :show, params: { id: @collective1.id }
        expect(response).to be_successful
    end

    it 'get show redirects to collectives page given non relevant id' do
      expect(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
      expect(Collective).to receive(:find_by_id).with(@collective3.id.to_s).and_return(nil)

      get :show, params: { id: @collective3.id }
      expect(response).to redirect_to(collectives_path)
  end

    it 'get show selects show template to render' do
        allow(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
        allow(Collective).to receive(:find).with(@collective1.id.to_s).and_return(@collective1)

        get :show, params: { id: @collective1.id }
        expect(response).to render_template('show')
    end

    it 'makes the results available to that template' do
        allow(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
        allow(Collective).to receive(:find).with(@collective1.id.to_s).and_return(@collective1)

        get :show, params: { id: @collective1.id }
        expect(assigns(:collective)).to eq(@collective1)
    end
end

end