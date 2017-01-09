FactoryGirl.define do
  factory :comment do
    trait :active do
      title 'I am the first comment'
      content '... and I like to be first'
    end

    trait :inactive do
      title 'I am the second comment'
      content '... and I like to be second... not!'
      active false
    end
    
  end
end