FactoryGirl.define do
  factory :kill, class: 'Game::Kill' do
    killer
    victim
    round
  end
end
