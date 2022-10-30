require 'rails_helper'

describe ChatsController do
    login_user
    
    it 'Index shows all chats of a profile' do
        get :index
        expect(response).to be_successful
    end
end