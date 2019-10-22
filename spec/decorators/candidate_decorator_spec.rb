require 'rails_helper'

describe EmployeeCandidatePresenter do
  context '#awaiting_invites_badge' do
    it 'show pending invites' do
      company = create(:company)
      candidate = create(:candidate)
      employee = create(:employee, company: company)
      create(:candidate_profile, candidate: candidate)
      position = create(:position, company: company)
      create(:invite, candidate: candidate, position: position)

      login_as(employee, scope: :employee)
      candidate = EmployeeCandidatePresenter.new(candidate, employee)
      expect(candidate.awaiting_invites_badge).to(
        include 'Aguardando aceite de convite'
      )
    end

    it 'is blank where there are no invites' do
      company = create(:company)
      candidate = create(:candidate)
      employee = create(:employee, company: company)
      create(:candidate_profile, candidate: candidate)
      create(:position, company: company)

      candidate = EmployeeCandidatePresenter.new(candidate, employee)
      expect(candidate.awaiting_invites_badge).to be_blank
    end
  end

  context '#invited_positions' do
    it 'has to show invited positions' do
      company = create(:company, url_domain: 'revelo.com.br')
      employee = create(:employee, company: company)
      candidate = create(:candidate)
      create(:candidate_profile, candidate: candidate)
      position = create(:position, company: company)
      position_uninvited = create(:position, company: company)
      create(:invite, candidate: candidate, position: position)

      employee_candidate_presenter =
        EmployeeCandidatePresenter.new(candidate, employee)
      invited_positions = employee_candidate_presenter.invited_positions

      expect(invited_positions.count).to eq 1
      expect(invited_positions).to include position
      expect(invited_positions).not_to include position_uninvited
    end
  end

  context '#uninvited_positions' do
    it 'has to show uninvited positions' do
      company = create(:company, url_domain: 'revelo.com.br')
      employee = create(:employee, company: company)
      candidate = create(:candidate)
      create(:candidate_profile, candidate: candidate)
      position = create(:position, company: company)
      position_uninvited = create(:position, company: company)
      create(:invite, candidate: candidate, position: position)

      employee_candidate_presenter =
        EmployeeCandidatePresenter.new(candidate, employee)
      uninvited_positions = employee_candidate_presenter.uninvited_positions

      expect(uninvited_positions.count).to eq 1
      expect(uninvited_positions).not_to include position
      expect(uninvited_positions).to include position_uninvited
    end
  end
end
