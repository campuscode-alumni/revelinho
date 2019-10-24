class CompaniesController < ApplicationController
  before_action :authenticate_employee!, only: %i[index edit update dashboard]
  before_action :set_company, only: %i[edit update show]
  before_action :set_company_profile, only: %i[show]
  before_action :own_company, only: %i[edit update]
  before_action :employee_pending, except: %i[edit update]

  def index; end

  def edit; end

  def update
    if @company.update(company_params)
      @company.active!
      redirect_to company_path(@company)
    else
      render :edit
    end
  end

  def show; end

  def dashboard
    @company_link = CompanyProfilePresenter.new(current_employee.company)
                                           .company_profile_link
  end

  def invites
    @company_invites = current_employee.company.invites
    @invite_presenter = InvitePresenter.new<div class="invite-card">
    <section class="invites-info rounded px-4 py-3">
    <div class="row">
      <div class="col-md-9">
        <h2><%= invite.position.title%></h2>
        <p><span>Data do convite:</span> <%= l(invite.created_at, format: :long) %></p>
        <p><span>Faixa salarial:</span> <%= number_to_currency invite.position.salary_from %>-<%= number_to_currency invite.position.salary_to %> </p>
        <p><span>Área de atuação:</span> <%=invite.position.industry %></p>
        <p><span>Descrição do cargo:</span> <%=invite.position.description%></p>
        <p><span>Regime de Contratação:</span> <%= t(:"position_type.#{invite.position.position_type}") %></p>
      </div>
       <div class="col-md-3 d-flex align-items-end flex-wrap align-content-end">
        <%= @invite_presenter.invite_accepted(invite) %>
        <%= @invite_presenter.invite_rejected(invite) %>
        <%= @invite_presenter.invite_pending_company(invite) %>
      </div>
    </div>
    </section>
  </div>

  end

  private

  def set_company_profile
    @company_profile = @company.company_profile
  end

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :address)
  end

  def own_company
    redirect_to company_path(current_employee.company) unless
    current_employee.company == @company
  end

  def employee_pending
    employee = current_employee
    return redirect_to edit_company_path(employee.company) if
    employee_signed_in? && employee.company.pending?
  end
end
