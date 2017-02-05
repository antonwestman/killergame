require 'rails_helper'
RSpec.describe 'Game::Kills', type: :request do
  let!(:user) { create(:user) }

  describe 'GET /kills' do
    let(:round) { create(:round) }
    before do
      create_list(:kill, 5, round: round)
    end

    context 'user is admin' do
      let(:admin) { create(:admin) }
      it 'returns list of kills' do
        get_with_user admin, game_round_kills_path(round)
        expect(response).to have_http_status(200)
        expect(response_data.count).to eq 5
      end
    end

    context 'user is reglar user' do
      it 'resoponds with 401' do
        get_with_user user, game_round_kills_path(round)
        expect(response).to have_http_status(401)
      end
    end
  end
  describe 'POST /kills' do
    let!(:round) { create(:round) }
    let!(:player) { create(:player, user: user, round: round) }
    let!(:victim) { create(:player, round: round) }
    let!(:some_other_dude) { create(:player) }

    before do
      create(:mission, player: player, target: victim)
    end

    context 'valid kill' do
      it 'responds with 201' do
        post_with_user user, game_round_kills_path(round, victim_id: victim.id)
        expect(response).to have_http_status(201)
      end
    end
    context 'invalid kill' do
      let!(:another_user) { create(:user) }

      it 'responds with 401' do
        post_with_user another_user, game_round_kills_path(round, victim_id: some_other_dude.id)
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'confirming/opposing kills' do
    let(:round) { create(:round) }
    let(:player) { create(:player, round: round) }
    let!(:victim) { create(:player, user: user, round: round) }
    let!(:kill) { create(:kill, victim: victim, killer: player, round: round) }

    describe 'PUT /kills/:id/confirm' do
      context 'kill does not exist' do
        it 'returns 404' do
          put_with_user user, confirm_game_kill_path(1234)
          expect(response).to have_http_status(404)
        end
      end
      context 'kill exist' do
        context 'user can confirm kill' do
          it 'responds with 200' do
            put_with_user user, confirm_game_kill_path(kill)
            expect(response).to have_http_status(200)
            expect(victim.reload.dead?).to be_truthy
          end
        end
        context 'user can not confirm kill' do
          let!(:another_user) { create(:user) }

          it 'responds with 401' do
            put_with_user another_user, confirm_game_kill_path(kill)
            expect(response).to have_http_status(401)
            expect(victim.reload.dead?).to be_falsy
          end
        end
      end
    end

    describe 'PUT /kills/:id/oppose' do
      context 'kill does not exist' do
        it 'returns 404' do
          put_with_user user, oppose_game_kill_path(1234)
          expect(response).to have_http_status(404)
        end
      end
      context 'kill exist' do
        context 'user can oppose kill' do
          it 'responds with 200' do
            put_with_user user, oppose_game_kill_path(kill)
            expect(response).to have_http_status(200)
            expect(victim.reload.alive?).to be_truthy
          end
        end
        context 'user can not oppose kill' do
          let!(:another_user) { create(:user) }

          it 'responds with 401' do
            put_with_user another_user, oppose_game_kill_path(kill)
            expect(response).to have_http_status(401)
            expect(victim.reload.alive?).to be_falsy
          end
        end
      end
    end
  end
end
