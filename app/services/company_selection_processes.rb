class CompanySelectionProcesses
  attr_accessor :selection_processes

  def initialize(company)
    @selection_processes = SelectionProcess
                           .joins(invite: { position: [:company] })
                           .where(positions: { company_id: company.id })
  end

  def all
    @selection_processes
  end

  def presenter
    CompanySelectionProcessesPresenter.new(@company)
  end
end
