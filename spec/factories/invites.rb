FactoryBot.define do
  factory :invite do
    message { 'We want YOU!' }
    status { 1 }
    candidate
    position
  end
end
