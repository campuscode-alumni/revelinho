FactoryBot.define do
  factory :invite do
    message { 'We want YOU!' }
    status { 0 }
    candidate
    position
  end
end
