require 'rails_helper'

describe ChatsController do

    before :each do
        @profile1 = create(:profile)
        @profile2 = create(:profile)
        @profile3 = create(:profile)
        @profile4 = create(:profile)
        
        @f1 = create(:friend, profile_id: @profile1.id, friend_id: @profile2.id)
        @f2 = create(:friend, profile_id: @profile2.id, friend_id: @profile3.id)

    end
    
    describe 'all_friends' do
        it 'right number of friends' do
            expect(@profile1.friends.length).to eq(1)
            expect(@profile2.friends.length).to eq(2)
            expect(@profile3.friends.length).to eq(1)
            expect(@profile4.friends.length).to eq(0)
        end
    end
end