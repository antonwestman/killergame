require 'rails_helper'

RSpec.describe 'Game::Kills', type: :request do
  let(:user) { build(:user) }

  describe 'GET /kills' do
    let(:round) { create(:round) }

    it 'resoponds with 401' do
      get_with_user user, game_round_kills_path(round)
      expect(response).to have_http_status(401)
    end
  end
end
