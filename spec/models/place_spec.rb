require 'rails_helper'

RSpec.describe Place, type: :model do
  it { expect(build(:place)).to be_valid }
end
