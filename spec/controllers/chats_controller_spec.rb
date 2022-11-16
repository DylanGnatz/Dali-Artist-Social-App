require 'rails_helper'

describe ChatsController do
    login_user

    before :each do
        @profile1 = @user.profile
        @profile2 = create(:user).profile
        @profile3 = create(:user).profile
        @profile4 = create(:user).profile

        @chat1 = create(:chat, profiles: [@profile1, @profile2])
        @chat2 = create(:chat, profiles: [@profile1, @profile3])
        @chat3 = create(:chat, profiles: [@profile1, @profile2, @profile3])
        @collective1 = create(:collective, profiles: [@profile1, @profile2, @profile3], chat:@chat3)

        @profile1.chats = [@chat1, @chat2]
        @profile1.collectives = [@collective1]

        msg1 = create(:chats_message, profile: @profile1, msg: "hey", chat:@chat1)
        msg2 = create(:chats_message, profile: @profile2, msg: "hey yo", chat:@chat1)

        @chat1.chats_messages = [msg1, msg2]
    end
    
    describe 'get index' do
        it 'shows all chats of a profile' do
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
            chats_ex = [{ name: @profile2.username, id: @chat1.id }, { name: @profile3.username, id: @chat2.id }]
            expect(assigns(:chats)).to eq(chats_ex)
            expect(assigns(:collective_chats)).to eq([{ name: @collective1.name, id: @chat3.id }])
        end
    end

    describe 'get show' do
        it 'shows a chat given id' do
            expect(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
            expect(Chat).to receive(:find_by_id).with(@chat1.id.to_s).and_return(@chat1)

            get :show, params: { id: @chat1.id }
            expect(response).to be_successful
        end

        it 'redirects to chats page given non relevant id' do
            chat3 = create(:chat, profiles: [@profile3, @profile4])
            expect(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
            expect(Chat).to receive(:find_by_id).with(chat3.id.to_s).and_return(nil)

            get :show, params: { id: chat3.id }
            expect(response).to redirect_to(chats_path)
        end

        it 'selects show template to render' do
            allow(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
            allow(Chat).to receive(:find_by_id).with(@chat1.id.to_s).and_return(@chat1)

            get :show, params: { id: @chat1.id }
            expect(response).to render_template('show')
        end

        it 'makes the results available to that template' do
            allow(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
            allow(Chat).to receive(:find_by_id).with(@chat1.id.to_s).and_return(@chat1)

            get :show, params: { id: @chat1.id }
            messages_ex = [{ msg: 'hey', from_profile: true, sender: @profile1.username }, 
                { msg: 'hey yo', from_profile: false, sender: @profile2.username }]
            expect(assigns(:messages)).to eq(messages_ex)
            expect(assigns(:name)).to eq(@profile2.username)
        end

        it 'assigns correct name fore collective chats' do
            allow(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
            allow(Chat).to receive(:find_by_id).with(@chat3.id.to_s).and_return(@chat3)

            get :show, params: { id: @chat3.id }
            expect(assigns(:name)).to eq(@collective1.name)
        end
    end

    describe 'post create' do
        it 'creates a new chat if a chat between two friends doesnt exist' do
            expect(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
            expect(Profile).to receive(:find_by_username).with(@profile4.username).and_return(@profile4)

            chat3 = create(:chat, profiles: [@profile1, @profile4])
            expect(Chat).to receive(:create!).and_return(chat3)

            expect(ChatsProfile).to receive(:create!).with(chat_id: chat3.id, profile_id: @profile1.id)
            expect(ChatsProfile).to receive(:create!).with(chat_id: chat3.id, profile_id: @profile4.id)

            post :create, params: { username: @profile4.username }
            expect(response).to redirect_to(chat_path(chat3.id))
        end

        it 'redirects to an old chat if a chat between two friends exist' do
            expect(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
            expect(Profile).to receive(:find_by_username).with(@profile2.username).and_return(@profile2)

            post :create, params: { username: @profile2.username }
            expect(response).to redirect_to(chat_path(@chat1.id))
        end
        
    end
end