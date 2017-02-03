require 'rails_helper'

RSpec.describe Game::Player, type: :model do
  let(:player) { build(:player) }

  it { expect(player).to be_valid }
end
