require 'rails_helper'

RSpec.describe Game::KillsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/game/rounds/1/kills').to route_to(controller: 'game/kills',
                                                      action: 'index',
                                                      round_id: '1')
    end
  end
end
