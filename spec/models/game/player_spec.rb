require 'rails_helper'

RSpec.describe Game::Player, type: :model do
  it { expect(build(:player)).to be_valid }
end
