require 'rails_helper'

RSpec.describe Game::Kill, type: :model do
  it { expect(build(:kill)).to be_valid }
end
