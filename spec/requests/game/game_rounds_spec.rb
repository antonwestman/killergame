require 'rails_helper'

RSpec.describe 'Game::Rounds', type: :request do
  let(:user) { build(:user) }

  describe 'GET /game/rounds' do
    before do
      create_list(:round, 12)
    end
    it 'returns paginated game rounds' do
      get_with_user user, game_rounds_path
      expect(response).to have_http_status(200)
      expect(response_data.count).to eq 10
    end
  end

  describe 'GET /game/rounds/:id' do
    let(:round) { create(:round) }

    it 'returns a round' do
      get_with_user user, game_round_path(round)
      expect(response).to have_http_status(200)
      expect(response_data[:ongoing]).to be true
    end
  end
  describe 'GET /game/rounds/:id/me' do
    let(:round) { create(:round, with_users: [user]) }
    let(:another_user) { create(:user) }

    context 'current user is part of game' do
      it 'returns player' do
        get_with_user user, me_game_round_path(round)
        expect(response).to have_http_status(200)
      end
    end

    context 'current user is not part of game' do
      it 'returns 401' do
        get_with_user another_user, me_game_round_path(round)
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'POST /game/rounds' do
    let(:users) { create_list(:user, 3) }

    context 'weapons and places exist in db' do
      before do
        create_list(:weapon, 3)
        create_list(:place, 3)
      end

      it 'creates and returns round' do
        post_with_user user, game_rounds_path(user_ids: users.map(&:id), name: 'Killingtime')
        expect(response).to have_http_status(201)
        expect(response_data[:alive_players_count]).to eq 3
      end
    end

    context 'no weapons or places exist in db' do
      it 'raises' do
        expect {
          post_with_user user,
                         game_rounds_path(user_ids: users.map(&:id))
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'DELETE /game/rounds/:id' do
    let(:round) { create(:round) }
    context 'when user is not admin' do
      it 'returns status 401 (and does not delete round)' do
        delete_with_user user, game_round_path(round)
        expect(response).to have_http_status(401)
        expect(round.reload.persisted?).to be true
      end
    end
    context 'when user is admin' do
      let!(:round) { create(:round, with_admin: user) }
      it 'returns deletes round' do
        expect {
          delete_with_user user, game_round_path(round)
          expect(response).to have_http_status(204)
        }.to change { Game::Round.count }.by(-1)
      end
    end
  end
end
