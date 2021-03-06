require 'rails_helper'

describe 'InviteHelper' do
  context '#invite_accepted' do
    it 'has to present a message if invite is accepted by candidate' do
      candidate = create(:candidate, status: :published)
      invite = create(:invite, status: :accepted, accepted_or_rejected_at:
                      Date.current)
      invite_link = InvitePresenter.new(invite, candidate).invite_links

      expect(invite_link).to include('Esse convite foi aceito')
    end
    it 'has to present a message if invite is accepted by employee' do
      company = create(:company)
      employee = create(:employee, company: company)
      invite = create(:invite, status: :accepted, accepted_or_rejected_at:
                      Date.current)
      invite_link = InvitePresenter.new(invite, employee).invite_links

      expect(invite_link).to include('Esse convite foi aceito')
    end
  end

  context '#invite_rejected' do
    it 'has to present a message if invite is rejected by candidate' do
      candidate = create(:candidate, status: :published)
      invite = create(:invite, status: :rejected, accepted_or_rejected_at:
                      Date.current)
      invite_link = InvitePresenter.new(invite, candidate).invite_links

      expect(invite_link).to include('Esse convite foi rejeitado ')
    end
    it 'has to present a message if invite is rejected by employee' do
      company = create(:company)
      employee = create(:employee, company: company)
      invite = create(:invite, status: :rejected, accepted_or_rejected_at:
                      Date.current)
      invite_link = InvitePresenter.new(invite, employee).invite_links

      expect(invite_link).to include('Esse convite foi rejeitado ')
    end
  end

  context '#invite_pending' do
    it 'has to present accept/reject buttons if invite is pending' do
      candidate = create(:candidate, status: :published)
      invite = create(:invite, status: :pending)
      invite_link = InvitePresenter.new(invite, candidate).invite_links

      expect(invite_link).to include('Rejeitar convite')
      expect(invite_link).to include('Aceitar convite')
    end

    it 'not has to present accept/reject buttons unless invite is pending' do
      candidate = create(:candidate, status: :published)
      invite = create(:invite, status: :accepted)
      invite_link = InvitePresenter.new(invite, candidate).invite_links

      expect(invite_link).to_not include('Aceitar convite')
    end
  end
end
