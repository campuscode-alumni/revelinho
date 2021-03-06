class CandidateDashboardDecorator < Draper::Decorator
  include Draper::LazyHelpers

  def initialize(candidate)
    @candidate = candidate
  end

  def header_text
    "Olá #{candidate.name}!"
  end

  def info_header_text
    if published?
      content_tag(:p, 'Seu perfil está ativo. Aguarde o contato das '\
                      'empresas interessadas.')
    else
      content_tag(:p, 'Seu perfil ainda não está ativo. Complete-o e '\
                      'fique visível para as empresas.') +
        link_finish_profile
    end
  end

  def card_render
    if published?
      render(partial: 'shared/dashboard_card_button',
             locals: card_locals('fa-envelope-open-text', Invite.name))
    else
      ''
    end
  end

  private

  attr_accessor :candidate

  def card_locals(icon, class_name)
    { icon: icon,
      title: title(class_name),
      count: count(class_name),
      id: "#{class_name.pluralize.downcase}-card",
      path: path(class_name) }
  end

  def published?
    candidate.published?
  end

  def count(class_name)
    candidate.send(class_name.pluralize.downcase).count
  end

  def path(class_name)
    class_name.pluralize.downcase.to_s
  end

  def title(class_name)
    I18n.t("activerecord.models.#{class_name.downcase}").pluralize
  end

  def link_finish_profile
    link_to 'Concluir perfil', new_candidate_profile_path,
            class: 'btn btn-primary btn-large'
  end
end
