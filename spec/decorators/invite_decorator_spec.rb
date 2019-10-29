require 'rails_helper'

RSpec.describe InviteDecorator do
  context '#invite_links' do
    it 'show links accept/reject if invite is pending' do
      invite = create(:invite, status: :pending).decorate
      expect(invite.invite_links).to eq '<a class="btn btn-success flex-grow-1'\
                                        ' m-3" rel="nofollow" data-method="pos'\
                                        't" href="/candidates/1/invites/accept'\
                                        '/1">Aceitar</a><a class="btn btn-dang'\
                                        'er flex-grow-1 m-3" rel="nofollow" da'\
                                        'ta-method="post" href="/candidates/1/'\
                                        'invites/reject/1">Rejeitar</a>'
    end

    it 'show link proccess unless invite is pending' do
      invite = create(:invite).decorate
      expect(invite.invite_links).to eq '<a class="btn btn-success flex-grow-1'\
                                        ' m-3" rel="nofollow" data-method="pos'\
                                        't" href="/candidates/1/invites/accept'\
                                        '/1">Aceitar</a><a class="btn btn-dang'\
                                        'er flex-grow-1 m-3" rel="nofollow" da'\
                                        'ta-method="post" href="/candidates/1/'\
                                        'invites/reject/1">Rejeitar</a>'
    end
  end

  context '#logo' do
    it 'shows the company\'s logo when it exists' do
      company = create(:company)
      company.company_profile = create(:company_profile, company: company)
      position = create(:position, company: company)
      invite = create(:invite, status: :pending, position: position).decorate

      expect(invite.logo.blob.filename).to(
        eq invite.company_profile.logo.blob.filename
      )
    end

    it 'shows a image place holder when company logo does not exists' do
      company = create(:company)
      company.company_profile = create(:company_profile, :without_logo,
                                       company: company)
      position = create(:position, company: company)
      invite = create(:invite, status: :pending, position: position).decorate

      expect(invite.logo).to(
        eq 'https://github.com/identicons/jasonlong.png'
      )
    end
  end
end
