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

  describe 'POST /game/rounds' do
    let(:users) { create_list(:user, 3) }

    it 'creates and returns round' do
      post_with_user user, game_rounds_path(user_ids: users.map(&:id))
      expect(response).to have_http_status(201)
      expect(response_data[:alive_players_count]).to eq 3
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
