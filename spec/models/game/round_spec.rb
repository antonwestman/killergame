require 'rails_helper'

RSpec.describe Game::Round, type: :model do
  let(:round) { build(:round) }

  it { expect(round).to be_valid }

  describe '#declare winner' do
    it 'updates ongoing from true to false' do
      expect { round.declare_winner! }.to change { round.ongoing }.from(true).to(false)
    end
  end

  describe '#finished?' do
    context 'when round is ongoing' do
      it 'returns false' do
        expect(round.finished?).to be false
      end
    end
    context 'when round is finished' do
      before do
        allow(round).to receive(:ongoing) { false }
      end
      it 'returns true' do
        expect(round.finished?).to be true
      end
    end
  end

  describe '#update_game_state!' do
    context 'when more than one player is alive' do
      let!(:round) { create(:round, with_users: create_list(:user, 2)) }
      it 'does not set ongoing to false' do
        expect { round.update_game_state! }.to_not(change { round.ongoing })
      end
    end

    context 'when only one player is left' do
      let!(:round) { create(:round, with_users: create_list(:user, 2)) }
      before do
        round.players.first.update_attribute(:status, 'dead')
      end
      it 'does not set ongoing to false' do
        expect { round.update_game_state! }.to change { round.ongoing }.from(true).to(false)
      end
    end
  end
end
