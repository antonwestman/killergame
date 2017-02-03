require 'rails_helper'

RSpec.describe Game::Kill, type: :model do
  let(:kill) { build(:kill) }

  it { expect(build(:kill)).to be_valid }
end
