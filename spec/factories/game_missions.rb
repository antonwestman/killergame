FactoryGirl.define do
  factory :mission, class: 'Game::Mission' do
    player
    weapon
    place
    target
  end
end
