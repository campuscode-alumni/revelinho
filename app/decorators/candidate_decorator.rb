class CandidateDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def invited_positions(employee)
    positions.where(company: employee.company)
  end

  def uninvited_positions
    current_employee.company.positions.where.not(id: positions.ids)
  end

  def no_invitable_positions?
    uninvited_positions.empty?
  end

  def awaiting_invites_badge(employee)
    return '' if invited_positions(employee).empty?

    content_tag(
      :span,
      'Aguardando aceite de convite',
      class: 'badge badge-info'
    )
  end
end
