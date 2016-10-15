require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(build(:user)).to be_valid }
end
