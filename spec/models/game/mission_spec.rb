require 'rails_helper'

RSpec.describe Game::Mission, type: :model do
  it { expect(build(:mission)).to be_valid }
end
