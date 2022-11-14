require 'rails_helper'

describe EventsController do
    login_user

    before :each do
        @profile1 = @user.profile
        @event1 = Event.create!(title: "title1", profile: @profile1)
    end

    describe 'post create' do
        it 'creates a new event' do
          expect(Event).to receive(:new).and_return(@event1)

          post :create, params: { event: {title: "title1"} }
          expect(response).to redirect_to(profiles_index_path)
        end
        
        it 'creates a new event (fail)' do
          post :create, params: { event: {title: ""} }
          response.status.should eq(422)
        end
    end
    
    describe 'get new' do
        it 'new event page' do
          get :new
          expect(response).to render_template("new")
        end
    end
    
    describe 'delete destroy' do
        it 'delete an event' do
          expect(Event).to receive(:find).and_return(@event1)

          post :destroy, params: {id: 1}
          expect(response).to redirect_to(profiles_edit_path)
        end
    end
end