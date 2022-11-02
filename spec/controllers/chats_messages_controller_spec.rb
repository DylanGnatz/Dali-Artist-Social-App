require 'rails_helper'

describe ChatsMessagesController do
    login_user

    before :each do
        @profile1 = @user.profile
        @profile2 = create(:profile)
        @chat1 = create(:chat, profiles: [@profile1, @profile2])
        @profile1.chats = [@chat1]
    end

    it 'post create adds a new chat message to a chat' do
        expect(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
        msg1 = create(:chats_message, profile: @profile1, msg: "Yo wasssup", chat:@chat1)
        expect(ChatsMessage).to receive(:create!)
            .with(chat_id: @chat1.id.to_s, profile_id: @profile1.id, msg: 'Yo wasssup').and_return(msg1)
        post :create, params: { chat_id: @chat1.id, chats_message: { msg: 'Yo wasssup' } }
    end

    it 'post create redirects to chat show page' do
        allow(Profile).to receive(:find_by).with(user_id: @user.id).and_return(@profile1)
        msg1 = create(:chats_message, profile: @profile1, msg: "Yo wasssup", chat:@chat1)
        allow(ChatsMessage).to receive(:create!)
            .with(chat_id: @chat1.id.to_s, profile_id: @profile1.id, msg: 'Yo wasssup').and_return(msg1)
        post :create, params: { chat_id: @chat1.id, chats_message: { msg: 'Yo wasssup' } }
        expect(response).to redirect_to(chat_path(@chat1.id))
    end
end
