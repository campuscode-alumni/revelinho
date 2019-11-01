FactoryBot.define do
  factory :interview do
    date { '2019-10-26' }
    time_from { '17:00' }
    time_to { '18:00' }
    format { :face_to_face }
    address { 'Av. Paulista, 2000' }
    selection_process
  end
end
