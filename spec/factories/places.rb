FactoryGirl.define do
  factory :place do
    sequence(:name) { |n| "Drottninggatan #{n}" }
  end
end
