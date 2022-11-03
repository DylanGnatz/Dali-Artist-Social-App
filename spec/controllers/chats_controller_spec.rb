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

        @profile1.chats = [@chat1, @chat2]

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
        end
    end

    describe 'get show' do
        it 'get show shows a chat given id' do
            expect(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
            expect(Chat).to receive(:find).with(@chat1.id.to_s).and_return(@chat1)

            get :show, params: { id: @chat1.id }
            expect(response).to be_successful
        end

        it 'get show selects show template to render' do
            allow(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
            allow(Chat).to receive(:find).with(@chat1.id.to_s).and_return(@chat1)

            get :show, params: { id: @chat1.id }
            expect(response).to render_template('show')
        end

        it 'makes the results available to that template' do
            allow(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
            allow(Chat).to receive(:find).with(@chat1.id.to_s).and_return(@chat1)

            get :show, params: { id: @chat1.id }
            messages_ex = [{ msg: 'hey', from_profile: true, sender: @profile1.username }, 
                { msg: 'hey yo', from_profile: false, sender: @profile2.username }]
            expect(assigns(:messages)).to eq(messages_ex)
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