Candidate.create!(email: 'paulo.antonio@candidato.com', password: '123456',
                  name: 'Paulo antonio', cpf: '1234567890', status: :published,
                  address: 'Rua Revelada, 10', phone: '(11) 98238-2341',
                  occupation: 'full stack developer', city: 'São Paulo',
                  state: 'São Paulo', country: 'Brasil', zip_code: '03141-030',
                  birthday: '12/04/1991', educational_level: 'mestrado')

Candidate.create!(email: 'jose.pedro@candidato.com', password: '123456',
                  name: 'José Pedro', cpf: '1234567890', status: :published,
                  address: 'Rua Revelada, 10', phone: '(11) 98238-2341',
                  occupation: 'full stack developer', city: 'São Paulo',
                  state: 'São Paulo', country: 'Brasil', zip_code: '03141-030',
                  birthday: '12/04/1991', educational_level: 'mestrado')

Candidate.all.each do |candidate|
  CandidateProfile.create!(
    work_experience: 'Sou rubysta master',
    education: 'mestrado concluído',
    skills: 'Node, React, Rails',
    coding_languages: 'Javascript, ruby',
    english_proficiency: 'Fluente',
    skype_username: 'candidate',
    linkedin_profile_url: 'candidate',
    github_profile_url: 'candidate',
    candidate: candidate
  )
end

company = Company.create!(name: 'Revelo', url_domain: 'revelo.com.br', status: :active)
company.company_profile = CompanyProfile.create!(company: company, full_description: 'Emprega pessoas e faz uns serviços', benefits: 'vt e vr',
                                         employees_number: '100-500', website: 'revelo.com.br', phone: '11 3030-3030',
                                         mission: 'Empregar pessoas', category: 'RH', attractives: 'Ambiente informal e as vezes tem fruta')

employee = Employee.create!(email: "joao.silva@revelo.com.br",
                 password: '123456', company: company)

company.positions.create!(title: 'Desenvolvedor', industry: 'Tecnologia',
                 description: 'Desenvolvedor fullstack em Ruby',
                 salary_from: 2000.00, salary_to: 3000.00, hiring_scheme: :clt,
                 office_hours: :full_time)

Invite.create!(candidate: Candidate.last, position: Position.last,
               status: :accepted, accepted_or_rejected_at: Date.today)

selection_process = Invite.last.create_selection_process

Message.create!(sendable: Candidate.first, selection_process: selection_process,
                text: 'Olá, obrigado pelo convite.')
Message.create!(sendable: Employee.first, selection_process: selection_process,
                text: 'Olá! Adoramos o seu perfil, '\
                      'podemos marcar uma entrevista?')

company.company_profile.logo.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'gatinho.jpg')), filename: "gatinho.jpg")
employee.avatar.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'gatinho.jpg')), filename: "gatinho.jpg")

Interview.create!(datetime: '2019-10-26 17:00:00', format: :face_to_face, address: 'Av. Paulista, 2000', selection_process: selection_process)
Interview.create!(datetime: '2019-08-30 07:00:00', format: :online, address: 'skype', selection_process: selection_process, status: :scheduled)
Interview.create!(datetime: '2019-07-26 12:34:56', format: :face_to_face, address: 'Av. Paulista, 2000', selection_process: selection_process, status: :canceled)
Interview.create!(datetime: '2019-10-20 17:00:00', format: :online, address: 'skype', selection_process: selection_process)