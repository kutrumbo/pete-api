FactoryBot.define do
  factory :event do
    name { 'running' }
    date { Date.today }
  end
end
