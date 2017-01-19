FactoryGirl.define do
  factory :comment do
    message  { Faker::Lorem.paragraph(2) }
  end
end
