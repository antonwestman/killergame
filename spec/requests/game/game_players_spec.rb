require 'rails_helper'

RSpec.describe 'Game::Players', type: :request do
  let(:user) { build(:user, username: 'Flexi') }

  describe 'GET /game/round/:round_id/players' do
    let(:round) { create(:round) }

    before do
      create(:player, :with_mission, round: round, user: user)
      create(:player)
    end

    it 'returns round players' do
      get_with_user user, game_round_players_path(round)
      expect(response).to have_http_status(200)
      expect(response_data.count).to eq 1
      expect(response_data.first[:username]).to eq 'Flexi'
    end

    describe 'paginating' do
      let!(:players) { create_list(:player, 12, round: round) }

      it 'returns 10 records per page' do
        get_with_user user, game_round_players_path(round)
        expect(response).to have_http_status(200)
        expect(response_data.count).to eq 10
      end
    end
  end

  describe 'GET /game/players/:id' do
    let(:player) { create(:player, user: user) }

    # TODO: Validate json schemas
    it 'returns a player' do
      get_with_user user, game_player_path(player)
      expect(response).to have_http_status(200)
      expect(response_data[:username]).to eq 'Flexi'
    end
  end
end
