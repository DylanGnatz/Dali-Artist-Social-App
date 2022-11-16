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

  describe 'post create' do
    it 'redirects to new collective path if no collective name given' do
        expect(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)

        post :create, params: { collective: { name: '' } }
        expect(response).to redirect_to(new_collective_path)
    end

    it 'redirects to new collective path if no members given' do
      expect(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)

      post :create, params: { collective: { name: 'GG Boys' } }
      expect(response).to redirect_to(new_collective_path)
    end

    it 'creates a collective given a name and members' do
      profiles = [@profile1, @profile2, @profile4, @profile5]
      expect(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
      chat4 = create(:chat, profiles: profiles)
      collective4 = create(:collective, profiles: profiles, chat:chat4)
      expect(Chat).to receive(:create!).and_return(chat4)
      expect(Collective).to receive(:create!).with(name: 'GG Boys', chat_id: chat4.id).and_return(collective4)
      expect(CollectivesProfile).to receive(:create!).with(collective_id: collective4.id, profile_id: @profile1.id).ordered
      expect(ChatsProfile).to receive(:create!).with(chat_id: chat4.id, profile_id: @profile1.id).ordered
      expect(CollectivesProfile).to receive(:create!).with(collective_id: collective4.id, profile_id: @profile2.id.to_s).ordered
      expect(ChatsProfile).to receive(:create!).with(chat_id: chat4.id, profile_id: @profile2.id.to_s).ordered
      expect(CollectivesProfile).to receive(:create!).with(collective_id: collective4.id, profile_id: @profile4.id.to_s).ordered
      expect(ChatsProfile).to receive(:create!).with(chat_id: chat4.id, profile_id: @profile4.id.to_s).ordered
      expect(CollectivesProfile).to receive(:create!).with(collective_id: collective4.id, profile_id: @profile5.id.to_s).ordered
      expect(ChatsProfile).to receive(:create!).with(chat_id: chat4.id, profile_id: @profile5.id.to_s).ordered

      members = {}
      members[@profile2.id.to_i] = 1
      members[@profile4.id.to_i] = 1
      members[@profile5.id.to_i] = 1
      post :create, params: { collective: { name: 'GG Boys' }, members: members }
      expect(response).to redirect_to(collectives_path)
    end
    
  end

  describe 'get new' do
    it 'shows the new collective page' do
        expect(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)

        get :new
        expect(response).to be_successful
    end
    it 'selects the new template to render' do
      expect(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)

      get :new
      expect(response).to render_template('new')
    end
  end
end