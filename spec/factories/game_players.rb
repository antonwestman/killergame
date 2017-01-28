FactoryGirl.define do
  factory :player, aliases: [:target, :killer, :victim], class: 'Game::Player' do
    user
    round
  end
end
