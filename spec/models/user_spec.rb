require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(FactoryGirl.create(:user)).to be_valid }
end
