class CompanyInvites
  attr_accessor :invites

  def initialize(company)
    @invites = Invite.includes(:position)
                     .where(positions: { company: company })
  end
end
