FactoryGirl.define do
  factory :round, class: 'Game::Round' do
    transient do
      with_admin nil
    end

    after(:create) do |round, evaluator|
      evaluator.with_admin&.add_role(:admin, round)
    end
  end
end
