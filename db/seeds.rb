c_paulo = Candidate.create!(email: 'paulo.antonio@candidato.com', password: '123456',
                  name: 'Paulo antonio', cpf: '1234567890', status: :published,
                  address: 'Rua Revelada, 10', phone: '(11) 98238-2341',
                  occupation: 'full stack developer', city: 'São Paulo',
                  state: 'São Paulo', country: 'Brasil', zip_code: '03141-030',
                  birthday: '12/04/1991', educational_level: 'mestrado')

c_jose = Candidate.create!(email: 'jose.pedro@candidato.com', password: '123456',
                  name: 'José Pedro', cpf: '1234567890', status: :published,
                  address: 'Rua Revelada, 10', phone: '(11) 98238-2341',
                  occupation: 'full stack developer', city: 'São Paulo',
                  state: 'São Paulo', country: 'Brasil', zip_code: '03141-030',
                  birthday: '12/04/1991', educational_level: 'mestrado')

Candidate.all.each do |candidate|
  profile = CandidateProfile.create!(
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
  profile.avatar.attach(io: File.open(Rails.root.join('spec', 'support',
                                                      'images',
                                                      'user-default.png')),
                        filename: 'user-default.png')
end

company = Company.create!(name: 'Revelo', url_domain: 'revelo.com.br',
                          status: :active)

employee = Employee.create!(name: 'João Silva', email: "joao.silva@revelo.com.br",
                            password: '123456', company: company)

position = Position.create!(
  title: 'Desenvolvedor',
  industry: 'Tecnologia',
  description: 'Desenvolvedor fullstack em Ruby',
  salary_from: 2000.00, salary_to: 3000.00, hiring_scheme: :clt,
  office_hours: :full_time,
  company_id: company.id
)

Invite.create!(candidate: c_jose, position: Position.last,
               status: :accepted, accepted_or_rejected_at: Date.today,
               employee: employee)

selection_process = Invite.last.create_selection_process

Message.create!(sendable: c_jose, selection_process: selection_process,
                text: 'Olá, obrigado pelo convite.')
Message.create!(sendable: employee, selection_process: selection_process,
                text: 'Olá! Adoramos o seu perfil, '\
                      'podemos marcar uma entrevista?')
offer_message = Message.create!(sendable: employee,
                                selection_process: selection_process,
                                text: 'Venha fazer parte da nossa equipe!')

offer = Offer.create!(salary: 2500.00, selection_process: selection_process,
                      hiring_scheme: :clt, status: :pending,
                      start_date: Date.current, employee: employee,
                      message: offer_message)

company.company_profile.logo.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'logo-revelo.png')), filename: "logo-revelo.png")
employee.avatar.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'user-default2.png')), filename: "user-default2.png")

Interview.create!(date: '2019-10-26', time_from: '10:00', time_to: '11:00', format: :face_to_face, address: 'Av. Paulista, 2000', selection_process: selection_process)
Interview.create!(date: '2019-08-30', time_from: '10:00', time_to: '11:00', format: :online, address: 'skype', selection_process: selection_process, status: :scheduled)
Interview.create!(date: '2019-07-26', time_from: '10:00', time_to: '11:00', format: :face_to_face, address: 'Av. Paulista, 2000', selection_process: selection_process, status: :canceled)
Interview.create!(date: '2019-10-20', time_from: '10:00', time_to: '11:00', format: :online, address: 'skype', selection_process: selection_process)
