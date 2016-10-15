require 'rails_helper'

RSpec.describe Game::PlayersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/game/players').to route_to('game/players#index')
    end

    it 'routes to #show' do
      expect(get: '/game/players/1').to route_to('game/players#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/game/players').to route_to('game/players#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/game/players/1').to route_to('game/players#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/game/players/1').to route_to('game/players#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/game/players/1').to route_to('game/players#destroy', id: '1')
    end
  end
end
