require 'rails_helper'

RSpec.describe 'Game::Kills', type: :request do
  let!(:user) { create(:user) }

  describe 'GET /kills' do
    let(:round) { create(:round) }

    it 'resoponds with 401' do
      get_with_user user, game_round_kills_path(round)
      expect(response).to have_http_status(401)
    end
  end

  describe 'PUT /kills/:id/confirm' do
    context 'kill does not exist' do
      it 'returns 404' do
        put_with_user user, confirm_game_kill_path(1234)
        expect(response).to have_http_status(404)
      end
    end
    context 'kill exist' do
      let(:round) { create(:round) }
      let(:player) { create(:player, round: round) }
      let(:victim) { create(:player, user: user, round: round) }
      let(:kill) { create(:kill, victim: victim, killer: player, round: round) }

      context 'user can confirm kill' do
        it 'responds with 401' do
          put_with_user user, confirm_game_kill_path(kill)
          expect(response).to have_http_status(200)
        end
      end
      context 'user can not confirm kill' do
        let!(:another_user) { create(:user) }

        it 'responds with 401' do
          put_with_user another_user, confirm_game_kill_path(kill)
          expect(response).to have_http_status(401)
        end
      end
    end
  end
end
