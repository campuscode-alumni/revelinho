require 'rails_helper'

RSpec.describe InviteDecorator do
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

      expect(invite.logo).to include 'placeholder'
    end
  end
end
