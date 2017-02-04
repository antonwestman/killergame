FactoryGirl.define do
  factory :kill, class: 'Game::Kill' do
    round { FactoryGirl.build(:round) }
    killer { |kill| FactoryGirl.build(:player, round: kill.round) }
    victim { |kill| FactoryGirl.build(:player, round: kill.round) }
  end
end
