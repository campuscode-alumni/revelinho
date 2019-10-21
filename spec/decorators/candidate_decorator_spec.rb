require 'rails_helper'

describe EmployeeCandidatePresenter do
  context '#awaiting_invites_badge' do
    it 'show pending invites' do
      company = create(:company, :active)
      candidate = create(:candidate)
      employee = create(:employee, company: company)
      create(:candidate_profile, candidate: candidate)
      position = create(:position, company: company)
      create(:invite, candidate: candidate, position: position)

      login_as(employee, scope: :employee)
      candidate = EmployeeCandidatePresenter.new(candidate, employee)
      expect(candidate).to be_decorated_with(EmployeeCandidatePresenter)
      expect(candidate.awaiting_invites_badge).to(
        include 'Aguardando aceite de convite'
      )
    end

    it 'is blank where there are no invites' do
      company = create(:company, :active)
      candidate = create(:candidate)
      employee = create(:employee, company: company)
      create(:candidate_profile, candidate: candidate)
      create(:position, company: company)

      candidate = EmployeeCandidatePresenter.new(candidate, employee)
      expect(candidate).to be_decorated_with(EmployeeCandidatePresenter)
      expect(candidate.awaiting_invites_badge).to be_blank
    end
  end
end
