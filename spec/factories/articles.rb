FactoryGirl.define do
  factory :article do
    trait :active do
      title 'I am the first article'
      content '... and I like to be first'
    end

    trait :inactive do
      title 'I am the second article'
      content '... and I like to be second... not!'
      active false
    end
    
  end
end