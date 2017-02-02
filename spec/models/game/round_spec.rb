require 'rails_helper'

RSpec.describe Game::Round, type: :model do
  let(:round) { build(:round) }

  it { expect(round).to be_valid }

  describe '#declare winner' do
    it 'updates ongoing from true to false' do
      expect { round.declare_winner! }.to change { round.ongoing }.from(true).to(false)
    end
  end
end
