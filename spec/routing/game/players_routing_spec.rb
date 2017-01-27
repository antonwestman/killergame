require 'rails_helper'

RSpec.describe Game::PlayersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: "/game/rounds/1/players").to route_to(controller: 'game/players', action: 'index', round_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/game/players/1').to route_to('game/players#show', id: '1')
    end
  end
end
