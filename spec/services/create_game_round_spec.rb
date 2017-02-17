require 'rails_helper'

RSpec.describe CreateGameRound, type: :model do
  let(:round_users) { build_list(:user, 2) }
  let(:admin) { round_users.first }
  let!(:non_round_user) { create(:user) }

  before do
    create_list(:weapon, 2)
    create_list(:place, 2)
  end

  it 'creating a game round' do
    expect {
      CreateGameRound.call(users: round_users, admin: admin)
    }.to change { Game::Round.count }.by 1
    expect(admin.reload).to have_role(:admin, Game::Round.first)
    expect(Game::Round.first.players.count).to eq 2
    expect(Game::Player.count).to eq 2
    expect(Game::Mission.count).to eq 2
  end
end
