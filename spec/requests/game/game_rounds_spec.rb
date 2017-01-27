require 'rails_helper'

RSpec.describe 'Game::Rounds', type: :request do
  describe 'GET /game_rounds' do
    it 'works! (now write some real specs)' do
      get game_rounds_path
      expect(response).to have_http_status(200)
    end
  end
end
