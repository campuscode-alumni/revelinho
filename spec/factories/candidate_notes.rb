FactoryBot.define do
  factory :candidate_note do
    comment { 'Mas o fit com esse candidato é fenomenal!' }
    employee
    candidate
    visibility { :to_all }
  end
end
