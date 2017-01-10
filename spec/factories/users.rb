FactoryGirl.define do
  factory :user do
  
    trait :admin do
      name 'admin'
      email 'admin@online.de'
      password 'sumcumo'
      password_confirmation 'sumcumo'
      admin_role true
    end
    
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