class CompanyInterviews
  attr_accessor :interviews

  def initialize(company)
    @interviews = Interview.includes(:position)
                           .where(positions: { company: company })
  end
end
