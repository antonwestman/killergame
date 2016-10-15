require 'rails_helper'

RSpec.describe 'Game::Players', type: :request do
  describe 'GET /game/players' do
    it 'responds' do
      get game_players_path
      expect(response).to have_http_status(200)
    end
  end
end
