require 'rails_helper'

RSpec.describe CreateGameRound, type: :model do

  let(:round_users) {build_list(:user, 2)}
  let!(:non_round_user) {create(:user)}

  it "creating a game round" do

    expect{CreateGameRound.call(users: round_users)}.to change{Game::Round.count}.by 1
    expect(Game::Round.first.players.count).to eq 2
    expect(Game::Player.count).to eq 2
    expect(Game::Mission.count).to eq 2
  end


end
