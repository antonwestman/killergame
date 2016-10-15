FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "#{Faker::Internet.user_name}-#{n}" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { |n| "killer#{n}@killergame.com" }
  end
end
