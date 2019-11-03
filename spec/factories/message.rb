FactoryBot.define do
  factory :message do
    text { 'Olá! Como vai você?' }
    sendable { |e| e.association(:employee) }
    selection_process
  end
end
