FactoryBot.define do
  factory :interview_feedback do
    message { 'A entrevista com o candidato foi super produtiva' }
    interview
    employee
  end
end
