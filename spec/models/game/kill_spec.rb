require 'rails_helper'
require 'byebug'

RSpec.describe Game::Kill, type: :model do
  let(:round) { create(:round) }
  let(:player) { create(:player, round: round) }

  let!(:asd) { create(:mission, player: player, target: victim) }
  let!(:asd1) { create(:mission, player: victim, target: player) }
  let(:victim) { create(:player, round: round) }

  it { expect(build(:kill)).to be_valid }

  describe 'validations' do
    let(:kill) { build(:kill) }

    it { is_expected.to validate_presence_of(:killer) }
    it { is_expected.to validate_presence_of(:victim) }
    it { is_expected.to validate_presence_of(:round) }

    it 'validates that all associated records belong to the same round' do
      kill.round = create(:round)
      expect(kill).to_not be_valid
      expect(kill.errors[:round]).to eq ['must be same in killer, victim and kill']
    end
  end

  describe '#confirm' do
    let!(:kill) { create(:kill, victim: victim, killer: player, round: round) }

    it 'asks round to update_game_state' do
      expect(kill.round).to receive(:update_game_state!)
      kill.confirm!
    end
  end

  describe 'after create' do
    describe '#mark_victim_as_killed' do
      context 'victim is killer (suicide)' do
        let!(:kill) { create(:kill, victim: victim, killer: victim, round: round) }

        it 'sets victim to dead and confirms kill' do
          expect(victim.dead?).to be_truthy
          expect(kill.confirmed?).to be_truthy
        end
      end

      context 'victim is other than killer' do
        let!(:kill) { create(:kill, victim: victim, killer: player, round: round) }

        it 'marks victim as killed' do
          expect(victim.marked_as_killed?).to be_truthy
          expect(kill.confirmed?).to be_falsy
        end
      end
    end
  end
end
