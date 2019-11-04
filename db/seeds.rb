candidates = [
  { name: 'Paulo Antonio', email: 'paulo.antonio@candidato.com',
    status: 'hidden', phone: '(11) 98238-2341', occupation: 'Dev Ruby' },
  { name: 'José Pedro', email: 'jose.pedro@candidato.com',
    status: 'published', phone: '(11) 98238-2341', occupation: 'Dev PHP' },
  { name: 'Márcia', email: 'marcia@candidato.com',
    status: 'published', phone: '(11) 98238-2341', occupation: 'Dev Phyton' },
  { name: 'Maria', email: 'maria@candidato.com',
    status: 'hidden', phone: '(11) 98238-2341', occupation: 'Dev Júnior' },
  { name: 'Lucas', email: 'lucas@kendidato.com',
    status: 'published', phone: '(11) 98238-2341', occupation: 'Ux Designer' },
  { name: 'Rafael', email: 'rafael@candidato.com',
    status: 'published', phone: '(11) 98238-2341', occupation: 'Dev Laravel' },
]

15.times do |i|
  candidates << { name: "Candidato #{i+1}", email: "candidato#{i+1}@candidato.com",
    status: ((i+1).odd? ? 'published' : 'hidden'), phone: '(11) 1111-1111',
    occupation: 'Dev Laravel' }
end

candidates.each do |cand,i|
  candidate = Candidate.create(name: cand[:name], email: cand[:email],
    phone: cand[:phone], status: cand[:status].to_sym, city: 'São Paulo',
    occupation: cand[:occupation], password: '123456', zip_code: '03141-030',
    cpf: '1234567890', address: 'Rua Revelada, 10', state: 'São Paulo',
    country: 'Brasil', birthday: '12/04/1991', educational_level: 'mestrado')

  next if candidate.hidden?

  profile = CandidateProfile.create!(
    work_experience: 'Sou rubysta master',
    education: 'mestrado concluído',
    skills: 'Node, React, Rails',
    coding_languages: 'Javascript, ruby',
    english_proficiency: 'Fluente',
    skype_username: "candidate.#{cand[:name].downcase}",
    linkedin_profile_url: "candidate/#{cand[:name].downcase}",
    github_profile_url: "github.com/candidate_#{cand[:name].downcase}",
    candidate: candidate
  )
  profile.avatar.attach(io: File.open(Rails.root.join('spec', 'support',
                                                      'images',
                                                      'user-default.png')),
                        filename: 'user-default.png')
end

revelo = Company.create!(name: 'Revelo', url_domain: 'revelo.com.br', status: :active)
contratado_me = Company.create!(name: 'Contratado ME', url_domain: 'contratado.com.br', status: :active)
campuscode = Company.create!(name: 'Campus Code', url_domain: 'campuscode.com.br', status: :active)
new_startup = Company.create!(name: 'NewStartup', url_domain: 'newstartup.com.br', status: :pending)


revelo.company_profile = CompanyProfile.create!(company: revelo, full_description: 'Emprega pessoas e faz uns serviços', benefits: 'vt e vr',
                                                employees_number: '100-500', website: 'revelo.com.br', phone: '11 3030-3030',
                                                mission: 'Empregar pessoas', category: 'RH', attractives: 'Ambiente informal e as vezes tem fruta')
contratado_me.company_profile = CompanyProfile.create!(company: contratado_me, full_description: 'Emprega pessoas e faz uns serviços', benefits: 'vt e vr',
                                                employees_number: '100-500', website: 'contratado.com.br', phone: '11 3030-3030',
                                                mission: 'Empregar pessoas', category: 'RH', attractives: 'Ambiente informal e as vezes tem fruta')
campuscode.company_profile = CompanyProfile.create!(company: campuscode,full_description: 'treinamos pessoas a serem auto-suficientes na carreira  de desenvolvimento de  software. acreditamos que saber programar muda a vida  das pessoas.',
                                                benefits: 'vt e vr', employees_number: '100-500', website: 'campuscode.com.br', phone: '11 3030-3030',
                                                mission: 'Empregar pessoas', category: 'RH', attractives: 'Melhor lanchinho da tarde da região')
    
employee_revelo = Employee.create!(name: 'João Silva', email: "joao.silva@revelo.com.br",
                            password: '123456', company: revelo)
Employee.create!(name: 'Rafael Timbó', email: "rafael.timbo@revelo.com.br",
  password: '123456', company: revelo)
Employee.create!(name: 'Jeferson', email: "jeferson@revelo.com.br",
  password: '123456', company: revelo)
Employee.create!(name: 'Pedro Paulo', email: "pedro.paulo@revelo.com.br",
  password: '123456', company: revelo)
Employee.create!(name: 'Lucas', email: "lucas@contratado.com.br",
  password: '123456', company: contratado_me)
Employee.create!(name: 'Henrique', email: "lucas@campuscode.com.br",
  password: '123456', company: campuscode)
Employee.create!(name: 'João', email: "joao@campuscode.com.br",
  password: '123456', company: campuscode)


revelo.positions.create!(title: 'Desenvolvedor', industry: 'Tecnologia',
                         description: 'Desenvolvedor fullstack em Ruby',
                         salary_from: 3000.00, salary_to: 4000.00,
                         hiring_scheme: :clt, office_hours: :full_time)
revelo.positions.create!(title: 'UX Designer', industry: 'TI',
                         description: 'Especialista em UX',
                         salary_from: 3000.00, salary_to: 4000.00,
                         hiring_scheme: :clt, office_hours: :full_time)
campuscode.positions.create!(title: 'Dev Senior em Ruby', industry: 'TI',
                         description: 'Desenvolvedor senior em Ruby',
                         salary_from: 4000.00, salary_to: 6000.00,
                         hiring_scheme: :clt, office_hours: :full_time)
contratado_me.positions.create!(title: 'Programador', industry: 'Tecnologia',
                                description: 'Programador WEBs',
                                salary_from: 2500.00, salary_to: 3500.00,
                                hiring_scheme: :clt, office_hours: :full_time)


revelo.company_profile.logo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'companies', 'logo-revelo.png')), filename: "logo-revelo.png")
campuscode.company_profile.logo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'companies', 'logo-campuscode.png')), filename: "logo-campuscode.png")

employee_revelo.avatar.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'user-default2.png')), filename: "user-default2.png")

Company.active.each_with_index do |company, i_company|
  Candidate.published.each_with_index do |candidate, i_candidate|
    position = i_candidate % 2 ? company.positions.last : company.positions.first
    invite = Invite.create!(candidate: candidate, position: position,
      status: :accepted, accepted_or_rejected_at: Date.today,
      employee: company.employees.first, message: 'Gostamos do seu perfil!')  
    selection_process = invite.create_selection_process
    Message.create!(sendable: company.employees.first, selection_process: selection_process,
      text: 'Olá! Adoramos o seu perfil, '\
            'podemos marcar uma entrevista?')
    Message.create!(sendable: candidate, selection_process: selection_process,
      text: 'Olá, obrigado pelo convite.')

    Interview.create!(date: '2019-11-26', time_from: '10:00', time_to: '11:00', format: :face_to_face, address: 'Av. Paulista, 2000', selection_process: selection_process)

    next unless i_candidate % 2

    offer_message = Message.create!(sendable: company.employees.first,
                      selection_process: selection_process,
                      text: 'Venha fazer parte da nossa equipe!')
    
    offer = Offer.create!(salary: 2500.00, selection_process: selection_process,
            hiring_scheme: :clt, status: :pending,
            start_date: (Date.current + 1.months), employee: company.employees.first,
            message: offer_message)
  end
end
