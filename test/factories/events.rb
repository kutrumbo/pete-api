FactoryBot.define do
  factory :event do
    name { 'running' }
    date { Date.today }
    time { Time.zone.now }
    source { 'client' }
    source_id { nil }
    details { {} }
  end
end
