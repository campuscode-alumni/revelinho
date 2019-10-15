# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Candidate.create!(
  name: 'Lucas',
  email: 'lucas@candidato.com',
  password: '123456',
  cpf: '1234567890',
  address: 'Rua Revelada, 10',
  occupation: 'full stack developer',
  educational_level: 'mestrado concluído',
  status: :published
)
Candidate.create!(
  name: 'Rafael',
  email: 'rafael@candidato.com',
  password: '123456',
  cpf: '1234567890',
  address: 'Rua Revelada, 10',
  occupation: 'back-end node.js developer',
  educational_level: 'graduação em andamento',
  status: :published
)
Candidate.create!(
  name: 'Gustavo',
  email: 'gustavo@candidato.com',
  password: '123456',
  cpf: '1234567890',
  address: 'Rua Revelada, 10',
  occupation: 'web developer',
  educational_level: 'graduação completa',
  status: :published
)
Candidate.create!(
  name: 'Patrícia',
  email: 'patricia@candidato.com',
  password: '123456',
  cpf: '1234567890',
  address: 'Rua Revelada, 10',
  occupation: 'dev ops guru',
  educational_level: 'mestrado concluído',
  status: :published
)