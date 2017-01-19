FactoryGirl.define do
  factory :invite do
    user_id { Faker::Number.between(1,10) }
    event_id { Faker::Number.between(1,10) }
    invited_user_id { Faker::Number.between(11,20) }
  end
end
