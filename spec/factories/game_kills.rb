FactoryGirl.define do
  factory :kill, class: 'Game::Kill' do
    association :killer, round_id: 1
    association :victim, round_id: 1
    association :round, id: 1
  end
end
