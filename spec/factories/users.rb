FactoryGirl.define do
  factory :user do
    trait :andy do
      name 'andy'
      email 'andreas.wenk@sumcumo.com'
      password 'sumcumo'
      password_confirmation 'sumcumo'
    end

    trait :other do
      name 'Andreas'
      email 'andreas@online.de'
      password 'sumcumo'
      password_confirmation 'sumcumo'
    end
  end
end