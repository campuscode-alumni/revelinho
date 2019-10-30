class CompanySelectionProcesses
  attr_accessor :selection_processes

  def initialize(company)
    @selection_processes = SelectionProcess
                           .where(company: company)
  end

  def all
    @selection_processes
  end
end
