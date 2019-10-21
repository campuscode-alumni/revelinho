class CandidateDashboardDecorator < Draper::Decorator
  include Draper::LazyHelpers

  def link_edit_profile
    link_to 'Editar Perfil', edit_candidate_profile_path(current_candidate.candidate_profile), class: "btn btn-primary btn-large"
  end

  def link_finish_profile
    link_to 'Concluir perfil', new_candidate_profile_path, class: "btn btn-primary btn-large"
  end

  def header_text
    "Olá #{current_candidate.name}!"
  end

  def info_header_text
    if published?
      content_tag(:p, 'Seu perfil está ativo. Aguarde o contato das empresas interessadas.')+
      link_edit_profile
    else
      content_tag(:p, 'Seu perfil ainda não está ativo. Complete-o e fique visível para as empresas.')+
      link_finish_profile
    end
  end

  def published?
    current_candidate.published?
  end

  def card icon, class_name
    link_to path(class_name), class: 'card order-card card-common link-defaut-color' do
      content_tag(:div, class: 'card-block') do
        content_tag(:h4, title(class_name), class: 'm-b-20') +
        content_tag(:h2, class: 'text-right') do
          content_tag(:i, nil, class: "fas #{icon} mr-2") +
          content_tag(:span, count(class_name))
        end
      end
    end
  end

  def cards
    if published?
      content_tag(:div, class: 'card-block') do
        content_tag(:div, card('fa-envelope-open-text', Invite.name), class: 'col-md-4 col-xl-4')#+
        # content_tag(:div, card('fa-edit', SelectionProcess.name), class: 'col-md-4 col-xl-4')+
        # content_tag(:div, card('fa-hands-helping', Proposal.name), class: 'col-md-4 col-xl-4')
      end
    else
      ''
    end
  end

  # private

  def count class_name
    current_candidate.send(class_name.pluralize.downcase).count
  end

  def path class_name
    "#{class_name.pluralize.downcase}"
  end

  def title class_name
    I18n.t("activerecord.models.#{class_name.downcase}").pluralize
  end
end
