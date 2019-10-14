FactoryBot.define do
  factory :candidate do
    name { 'John Doe' }
    cpf { '00000000000' }
    address { 'Rua da passargada, 90, São Paulo' }
    phone { '11 97070-7070' }
    occupation { 'Analista de sistemas' }
    educational_level { 'Superior completo' }
    email { 'teste@teste.com' }
    birthday { '31/02/2020' }
  end
end
