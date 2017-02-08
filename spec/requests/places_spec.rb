require 'rails_helper'

RSpec.describe 'Places', type: :request do
  let(:user) { build(:user) }

  describe 'GET /places' do
    before do
      create(:place, name: 'Grand Hotel')
    end

    it 'returns all places' do
      get_with_user user, places_path
      expect(response).to have_http_status(200)
      expect(response_data.first[:name]).to eq 'Grand Hotel'
    end

    describe 'search' do
      before do
        create(:place, name: 'Telephone booth')
        create(:place, name: 'Grocery store')
      end

      it 'returns places filtered by search string' do
        get_with_user user, places_path(q: { name_cont: 'tel' })
        expect(response).to have_http_status(200)
        expect(response_data.map { |w| w[:name] }).to match_array ['Grand Hotel', 'Telephone booth']
      end
    end
  end

  describe 'GET /places/:id' do
    let(:place) { create(:place, name: "Deviant's palace") }

    it 'returns a place' do
      get_with_user user, place_path(place)
      expect(response).to have_http_status(200)
      expect(response_data[:name]).to eq "Deviant's palace"
    end
  end

  describe 'POST /places' do
    context 'user is super_admin' do
      let(:super_admin) { create(:super_admin) }
      it 'creates and returns a place' do
        post_with_user super_admin, places_path(name: 'Kitchen')
        expect(response).to have_http_status(201)
        expect(response_data[:name]).to eq 'Kitchen'
      end
    end
    context 'user is regular user' do
      it 'creates and returns a place' do
        post_with_user user, places_path(name: 'Kitchen')
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'PUT /places/:id' do
    let(:place) { create(:place, name: 'Bathroom') }
    context 'user is super_admin' do
      let(:super_admin) { create(:super_admin) }
      it 'creates and returns a place' do
        put_with_user super_admin, place_path(place, name: 'Kitchen')
        expect(response).to have_http_status(200)
        expect(response_data[:name]).to eq 'Kitchen'
        expect(place.reload.name).to eq 'Kitchen'
      end
    end
    context 'user is regular user' do
      it 'creates and returns a place' do
        post_with_user user, places_path(name: 'Kitchen')
        expect(response).to have_http_status(401)
        expect(place.reload.name).to eq 'Bathroom'
      end
    end
  end

  describe 'DELETE /places/:id' do
    let!(:place) { create(:place, name: 'Escalator') }

    context 'user is regular user' do
      it 'returns 401 and keeps the place' do
        expect do
          delete_with_user user, place_path(place)
          expect(response).to have_http_status(401)
        end.to_not change { Place.count }
      end
    end

    context 'user is super_admin' do
      let(:super_admin) { create(:super_admin) }

      context 'place is not used in a game' do
        it 'deletes the place' do
          expect do
            delete_with_user super_admin, place_path(place)
          end.to change { Place.count }.by(-1)
        end
      end
      context 'place is used in game' do
        before do
          create_list(:player, 3, :with_mission, round: create(:round))
          Game::Mission.first.update_attribute :place, place
        end
        it 'returns 409 and keeps the place' do
          expect do
            delete_with_user super_admin, place_path(place)
            expect(response).to have_http_status(409)
          end.to_not change { Place.count }
        end
      end
    end
  end
end
