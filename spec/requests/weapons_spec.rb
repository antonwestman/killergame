require 'rails_helper'

RSpec.describe 'Weapons', type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  describe 'GET /weapons' do
    before do
      create(:weapon, name: 'Dental floss')
    end

    it 'returns weapons' do
      get_with_user user, weapons_path
      expect(response).to have_http_status(200)
      expect(response_data.first[:name]).to eq 'Dental floss'
    end

    describe 'search' do
      before do
        create(:weapon, name: 'Cell phone charger')
        create(:weapon, name: 'Wooden toy')
      end

      it 'returns weapons filtered by search string' do
        get_with_user user, weapons_path(q: { name_cont: 'den' })
        expect(response).to have_http_status(200)
        expect(response_data.map { |w| w[:name] }).to match_array ['Dental floss', 'Wooden toy']
      end
    end

    describe 'pagination' do
      before do
        create_list(:weapon, 14)
      end

      it 'paginates result' do
        get_with_user user, weapons_path
        expect(response).to have_http_status(200)
        expect(response_data.count).to eq 10
      end
    end
  end

  describe 'POST /weapons' do
    context 'user is admin' do
      it 'creates and returns a weapon' do
        post_with_user admin, weapons_path(name: 'Umbrella')
        expect(response).to have_http_status(201)
        expect(response_data[:name]).to eq 'Umbrella'
      end
    end
    context 'user is regular user' do
      it 'returns 401' do
        post_with_user user, weapons_path(name: 'Umbrella')
        expect(response).to have_http_status(401)
      end
    end
  end
end
