FactoryGirl.define do
  factory :round, class: 'Game::Round' do
    transient do
      with_admin nil
      with_users nil
    end

    after(:create) do |round, evaluator|
      evaluator.with_admin&.add_role(:admin, round)
      evaluator.with_users&.each do |user|
        create(:player, :with_mission, user: user, round: round)
      end
    end
  end
end
