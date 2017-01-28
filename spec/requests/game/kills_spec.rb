require 'rails_helper'

RSpec.describe 'Game::Kills', type: :request do
  describe 'GET /kills' do
    let(:round) { create(:round) }

    it 'works! (now write some real specs)' do
      get game_round_kills_path round
      expect(response).to have_http_status(200)
    end
  end
end
