lucas = Candidate.create!(
  name: 'Lucas',
  email: 'lucas@candidato.com',
  password: '123456',
  cpf: '1234567890',
  address: 'Rua Revelada, 10',
  phone: '(11) 98238-2341',
  occupation: 'full stack developer',
  educational_level: 'mestrado concluído',
  status: :published,
  city: 'São Paulo',
  state: 'São Paulo',
  country: 'Brasil',
  zip_code: '03141-030',
  birthday: '12/04/1991'
)
rafael = Candidate.create!(
  name: 'Rafael',
  email: 'rafael@candidato.com',
  password: '123456',
  cpf: '1234567890',
  address: 'Rua Revelada, 10',
  phone: '(11) 98238-2341',
  occupation: 'back-end node.js developer',
  educational_level: 'graduação em andamento',
  status: :published,
  city: 'São Paulo',
  state: 'São Paulo',
  country: 'Brasil',
  zip_code: '03141-030',
  birthday: '12/04/1991'
)
gustavo = Candidate.create!(
  name: 'Gustavo',
  email: 'gustavo@candidato.com',
  password: '123456',
  cpf: '1234567890',
  address: 'Rua Revelada, 10',
  phone: '(11) 98238-2341',
  occupation: 'web developer',
  educational_level: 'graduação completa',
  status: :published,
  city: 'São Paulo',
  state: 'São Paulo',
  country: 'Brasil',
  zip_code: '03141-030',
  birthday: '12/04/1991'
)
patricia = Candidate.create!(
  name: 'Patrícia',
  email: 'patricia@candidato.com',
  password: '123456',
  cpf: '1234567890',
  address: 'Rua Revelada, 10',
  phone: '(11) 98238-8765',
  occupation: 'dev ops guru',
  educational_level: 'mestrado concluído',
  status: :published,
  city: 'São Paulo',
  state: 'São Paulo',
  country: 'Brasil',
  zip_code: '03141-030',
  birthday: '23/04/1991'
)
CandidateProfile.create!(
  work_experience: 'Sou rubysta master',
  education: 'mestrado concluído',
  skills: 'Node, React, Rails',
  coding_languages: 'Javascript, ruby',
  english_proficiency: 'Fluente',
  skype_username: 'lucas',
  linkedin_profile_url: 'lucas',
  github_profile_url: 'lucas',
  candidate_id: lucas.id
)
CandidateProfile.create!(
  work_experience: 'Sou rubysta master',
  education: 'mestrado concluído',
  skills: 'Node, React, Rails',
  coding_languages: 'Javascript, ruby',
  english_proficiency: 'Fluente',
  skype_username: 'rafael',
  linkedin_profile_url: 'rafael',
  github_profile_url: 'rafael',
  candidate_id: rafael.id
)
CandidateProfile.create!(
  work_experience: 'Sou rubysta master',
  education: 'mestrado concluído',
  skills: 'Node, React, Rails',
  coding_languages: 'Javascript, ruby',
  english_proficiency: 'Fluente',
  skype_username: 'gustavo',
  linkedin_profile_url: 'gustavo',
  github_profile_url: 'gustavo',
  candidate_id: gustavo.id
)
CandidateProfile.create!(
  work_experience: 'Sou rubysta master',
  education: 'mestrado concluído',
  skills: 'Node, React, Rails',
  coding_languages: 'Javascript, ruby',
  english_proficiency: 'Fluente',
  skype_username: 'patricia.poke',
  linkedin_profile_url: 'patricia.poke',
  github_profile_url: 'patricia.poke',
  candidate_id: patricia.id
)

Employee.create!(
  email: 'timbo@empresa.com.br',
  password: '123456'
)

Company.create!(
  name: 'Empresa',
  address: 'Av. Paulista, 572',
  url_domain: 'empresa.com',
  status: :active
)

Position.create!(
  title: 'Desenvolvedor',
  position_type: :full_time,
  industry: 'TI',
  description: 'Conhecimentos em RoR',
  salary_to: 5000,
  salary_from: 6000,
  company_id: 1
)

Invite.create!(
  message: 'Olá mundo!',
  status: :accepted,
  position_id: 1,
  candidate_id: 1
)

SelectionProcess.create!(
  invite_id: 1
)
