FactoryBot.define do
  factory :user do
    athlete_id { Faker::Number.between(10000000, 99999999) }
    scope { 'foo' }
    access_token { Faker::Alphanumeric.alphanumeric(number: 40) }
    refresh_token { Faker::Alphanumeric.alphanumeric(number: 40) }
    expires_at { Time.zone.now }
  end
end
