FactoryGirl.define do
  factory :weapon do
    sequence(:name) { |n| "#{n} Rubber boot(s)" }
  end
end
