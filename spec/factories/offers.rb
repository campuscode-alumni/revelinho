FactoryBot.define do
  factory :offer do
    salary { 2500 }
    hiring_scheme { 0 }
    start_date { '2019-10-26' }
    status { 0 }
    message
    employee
    selection_process
  end
end
