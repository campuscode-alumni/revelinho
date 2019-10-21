class EmployeeCandidatePresenter < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  attr_reader :candidate, :employee

  def initialize(candidate, employee)
    @candidate = candidate
    @employee = employee
    super(candidate)
  end

  def invited_positions
    candidate.positions.where(company: employee.company)
  end

  def uninvited_positions
    employee.company.positions.where.not(id: candidate.positions.ids)
  end

  def no_invitable_positions?
    uninvited_positions.empty?
  end

  def awaiting_invites_badge
    return '' if invited_positions.empty?

    content_tag(
      :span,
      'Aguardando aceite de convite',
      class: 'badge badge-info'
    )
  end
end
