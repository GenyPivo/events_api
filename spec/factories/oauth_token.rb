FactoryGirl.define do
  factory :oauth_token, :class => Doorkeeper::AccessToken do
    #association :resource_owner_id
  end
end
