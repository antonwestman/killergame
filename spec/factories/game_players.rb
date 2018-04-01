FactoryGirl.define do
  factory :player, aliases: %i[target killer victim], class: 'Game::Player' do
    user
    round

    trait :with_mission do
      after(:build) do |player|
        player.missions << FactoryGirl.create(:mission)
      end
    end
  end
end
