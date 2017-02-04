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
    it 'creates and returns a place' do
      post_with_user user, places_path(name: 'Kitchen')
      expect(response).to have_http_status(201)
      expect(response_data[:name]).to eq 'Kitchen'
    end
  end
end
