FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "#{Faker::Internet.user_name}-#{n}" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |n| "killer#{n}@killergame.com" }
    uid(&:email)
    password 'password'
    password_confirmation 'password'
    confirmed_at Time.zone.now

    factory :super_admin do
      after(:build) do |user|
        user.add_role :super_admin
      end
    end
  end
end
