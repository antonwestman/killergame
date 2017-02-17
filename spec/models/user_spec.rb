require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(build(:user)).to be_valid }

  describe 'callbacks: ' do
    describe 'before_destroy' do
      let(:user) { create(:user) }
      let(:round_users) { create_list(:user, 2) }

      before do
        create_list(:weapon, 2)
        create_list(:place, 2)
        CreateGameRound.call(users: round_users << user, admin: user)
      end

      it 'transfers game data' do
        mission = user.players.first.mission
        targeter = user.players.first.contract_on_own_head.player
        user.destroy
        expect(targeter.reload
                       .mission
                       .slice('target_id',
                              'weapon_id',
                              'place_id')).to eq mission.slice('target_id',
                                                               'weapon_id',
                                                               'place_id')
      end
    end
  end
end
