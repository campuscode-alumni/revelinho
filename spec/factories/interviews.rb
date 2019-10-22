FactoryBot.define do
  factory :interview do
    datetime { '2019-10-26 17:00:00' }
    format { :face_to_face }
    address { 'Av. Paulista, 2000' }
    selection_process
  end
end
