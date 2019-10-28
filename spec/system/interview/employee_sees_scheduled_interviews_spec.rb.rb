require 'rails_helper'

feature 'Employee sees scheduled interviews' do
  xscenario 'successfully' do
    company = create(:company, url_domain: 'revelo.com.br')
    employee = create(:employee, email: 'renata@revelo.com.br',
                                 company: company)
    candidate = create(:candidate, name: 'Gustavo')
    candidate_2 = create(:candidate, name: 'Derick')
    create(:candidate_profile, candidate: candidate)
    create(:candidate_profile, candidate: candidate_2)
    position = create(:position, title: 'Engenheiro de Software Pleno',
                                 company: company)
    position_2 = create(:position, title: 'Dev Back End',
                                   company: company)
    invite = create(:invite, position: position, candidate: candidate,
                             status: :accepted)
    invite_2 = create(:invite, position: position_2, candidate: candidate_2,
                               status: :accepted)
    selection_process = create(:selection_process, invite: invite)
    selection_process_2 = create(:selection_process, invite: invite_2)
    create(:interview, date: DateTime.parse('25/11/2019'))
    create(:interview, date: DateTime.parse('28/11/2019'))

    login_as(employee, scope: :employee)
    visit interviews_path

    expect(current_path).to eq(selection_process_path(selection_process))
    within '.interviews' do
      expect(page).to have_content('25 de novembro de 2019')
      expect(page).to have_content('10:00')
      expect(page).to have_content('11:00')
      expect(page).to have_content(interview.address)
      expect(page).to have_content(I18n.t(:"format.#{interview.format}"))
    end
    expect(Interview.count).to eq(2)
  end
end
