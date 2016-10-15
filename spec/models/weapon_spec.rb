require 'rails_helper'

RSpec.describe Weapon, type: :model do
  it { expect(build(:weapon)).to be_valid }
end
