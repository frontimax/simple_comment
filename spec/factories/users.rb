FactoryGirl.define do
  factory :user do
    trait :andy do
      name 'andy'
      email 'andreas.wenk@sumcumo.com'
    end

    trait :other do
      name 'Andreas'
      email 'andreas@online.de'
    end
  end
end