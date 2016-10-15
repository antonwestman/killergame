FactoryGirl.define do
  factory :player, aliases: [:target], class: 'Game::Player' do
    user
    round
  end
end
