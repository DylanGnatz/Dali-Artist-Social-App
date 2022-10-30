require 'rails_helper'

describe ChatsController do
    login_user

    before :each do
        @profile1 = @user.profile
        profile2 = create(:profile)
        profile3 = create(:profile)

        chat1 = create(:chat, profiles: [@profile1, profile2])
        chat2 = create(:chat, profiles: [@profile1, profile3])

        @profile1.chats = [chat1, chat2]
    end
    
    it 'get index shows all chats of a profile' do
        expect(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
        get :index
        expect(response).to be_successful
    end

    it 'get index selects index template to render' do
        allow(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
        get :index
        expect(response).to render_template('index')
    end
end