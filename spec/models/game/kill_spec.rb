require 'rails_helper'

RSpec.describe Game::Kill, type: :model do
  let(:kill) { create(:kill) }

  it { expect(build(:kill)).to be_valid }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:killer) }
    it { is_expected.to validate_presence_of(:victim) }
    it { is_expected.to validate_presence_of(:round) }

    it 'validates that all associated records belong to the same round' do
      kill.round = create(:round)
      expect(kill).to_not be_valid
      expect(kill.errors[:round]).to eq ['must be same in killer, victim and kill']
    end
  end

  describe 'after create' do
    describe '#mark_victim_as_killed' do
      let(:round) { create(:round) }
      let(:player) { create(:player, round: round) }
      let(:victim) { create(:player, round: round) }

      context 'victim is killer (suicide)' do
        it 'sets victim to dead and confirms kill' do
          kill = Game::Kill.create(victim: victim,
                                   killer: victim,
                                   round: round)

          kill.reload
          victim.reload

          expect(victim.dead?).to be_truthy
          expect(kill.confirmed?).to be_truthy
        end
      end

      context 'victim is other than killer' do
        it 'marks victim killed' do
        end
      end
    end
  end
end
