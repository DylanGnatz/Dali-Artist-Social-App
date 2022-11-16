require 'rails_helper'

describe ProfilesController do
    login_user

    before :each do
        @profile = @user.profile
    end

    describe 'get index' do
      it 'index page' do 
        get :index
        expect(response).to render_template("index")
      end

      it 'profile belongs to logged in user' do
        get :index
        expect(@profile.user_id).to eq(@user.id)
      end
    end

    describe 'get edit' do
      it 'edit page' do 
        get :edit
        expect(response).to render_template("edit")
      end
    end
    
    describe 'put update' do
        it 'new event page' do
          expect(Profile).to receive(:find_by).and_return(@profile)

          put :update, params: {profile: {id: 1}}
          expect(response).to redirect_to(profiles_index_path)
        end
    end

    describe 'get show' do
      it 'show page' do 
        get :show, params: {id: @profile.id}
        expect(response).to render_template("show")
      end

      it 'profile belongs to logged in user' do
        get :show, params: {id: @profile.id}
        expect(@profile.user_id).to eq(@user.id)
      end
    end
    
    describe 'get location' do
      it 'with params' do
        expect(Profile).to receive(:find_by).and_return(@profile)
        get :location, params: {lat: 1, lng: 2}
        expect(@profile.lat).to eq(1)
        expect(@profile.lng).to eq(2)
      end
      it 'without params' do
        expect(Profile).to receive(:find_by).and_return(@profile)
        get :location, params: {}
      end
    end
    
    describe 'get feed' do
      it 'feed page' do 
        get :feed
        expect(response).to render_template("feed")
      end

      it 'number of feed items' do
        expect(Profile).to receive(:find_by).and_return(@profile)
        expect(@profile).to receive(:all_friends)
          .and_return([
            double("f1", artworks: [double("art")], events: []),
            double("f1", artworks: [], events: [double("event")]),
            double("f1", artworks: [double("art2")], events: [double("event2")]),
          ])

        get :feed
        feed_items = assigns(:feed_items)
        expect(feed_items.length).to eq(4)
      end
    end
    
end