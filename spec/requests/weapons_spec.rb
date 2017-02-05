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

  describe 'PUT /weapons/:id' do
    let(:weapon) { create(:weapon, name: 'Hair brush') }
    context 'user is admin' do
      it 'updates weapon' do
        put_with_user admin, weapon_path(weapon, name: 'Tooth picker')
        expect(response).to have_http_status(200)
        expect(response_data[:name]).to eq 'Tooth picker'
        expect(weapon.reload.name).to eq 'Tooth picker'
      end
    end

    context 'user is regular user' do
      it 'returns 401 (and does not update weapon)' do
        put_with_user user, weapon_path(weapon, name: 'Tooth picker')
        expect(response).to have_http_status(401)
        expect(weapon.reload.name).to eq 'Hair brush'
      end
    end
  end

  describe 'DELETE /weapons/:id' do
    let!(:weapon) { create(:weapon) }

    context 'user is regular user' do
      it 'returns 401 and keeps the weapon' do
        delete_with_user user, weapon_path(weapon)
        expect(response).to have_http_status(401)
        expect(weapon.persisted?).to be true
      end
    end
    context 'user is admin' do
      context 'weapon is not used in a game' do
        it 'deletes the weapon' do
          expect { delete_with_user admin, weapon_path(weapon) }.to change { Weapon.count }.by(-1)
        end
      end
      context 'weapon is used in a game' do
        before do
          create_list(:player, 3, :with_mission, round: create(:round))
          Game::Mission.first.update_attribute :weapon, weapon
        end

        it 'returns 401 and keeps the weapon' do
          delete_with_user admin, weapon_path(weapon)
          expect(response).to have_http_status(409)
          expect(weapon.persisted?).to be true
        end
      end
    end
  end
end
