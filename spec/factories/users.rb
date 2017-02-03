FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "#{Faker::Internet.user_name}-#{n}" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |n| "killer#{n}@killergame.com" }
    sequence(:uid) { |n| "killer#{n}@killergame.com" }
    password 'password'
    password_confirmation 'password'
    confirmed_at Time.zone.now
  end
end
