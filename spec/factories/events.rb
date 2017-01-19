FactoryGirl.define do
  factory :event do
    place  { Faker::Address.city + ', ' + Faker::Address.street_address }
    purpose  { Faker::Lorem.paragraph(4) }
    event_time { Faker::Date.forward(11).to_time }
  end
end