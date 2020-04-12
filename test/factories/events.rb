FactoryBot.define do
  factory :event do
    name { 'running' }
    time { Time.zone.now }
    source { 'client' }
    source_id { nil }
    details { {} }
  end
end
