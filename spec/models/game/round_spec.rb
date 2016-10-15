require 'rails_helper'

RSpec.describe Game::Round, type: :model do
  it { expect(build(:round)).to be_valid }
end
