FactoryGirl.define do
  factory :kill, class: 'Game::Kill' do
    killer { FactoryGirl.build(:player, round: FactoryGirl.build(:round, id: 1)) }
    victim { FactoryGirl.build(:player, round: FactoryGirl.build(:round, id: 1)) }
    round { FactoryGirl.build(:round, id: 1) }
  end
end
