FactoryGirl.define do
  factory :player, aliases: [:target, :killer, :victim], class: 'Game::Player' do
    user
    round

    trait :with_mission do
      after(:build) do |player|
        player.mission = FactoryGirl.create(:mission)
      end
    end
  end
end
