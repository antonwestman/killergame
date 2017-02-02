require 'rails_helper'

RSpec.describe 'Game::Players', type: :request do
  let(:user) { build(:user) }

  describe 'GET /game/players' do
    let(:round) { create(:round) }

    it 'responds' do
      get_with_user user, game_round_players_path(round)
      expect(response).to have_http_status(200)
    end
  end
end
