class CompanySelectionProcessesQuery
  delegate :count, to: :all

  def initialize(company)
    @company = company
  end

  def all
    SelectionProcess.joins(invite: { position: [:company] })
                    .where(positions: { company_id: @company.id })
  end

  private

  attr_accessor :company
end
