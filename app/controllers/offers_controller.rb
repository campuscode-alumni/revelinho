class OffersController < ApplicationController
  before_action :set_variables, only: %i[new create show accept reject]
  before_action :set_offer, only: %i[show accept reject]
  before_action :new_offer, only: %i[create]
  before_action :authenticate_employee!, only: %i[new create show]
  before_action :authenticate_candidate!, only: %i[accept reject]

  def new; end

  def create
    if @offer.present?
      @selection_process.offers << @offer
      OfferMailer.notify_candidate(@offer.id).deliver_now
      return redirect_to selection_process_candidates_path(@selection_process)
    end

    render :new
  end

  def show; end

  def accept
    action('accepted!', 'Oferta aceita!',
           'notify_accepted', 'offer_accepted')
  end

  def reject
    action('rejected!', 'Oferta rejeitada!',
           'notify_rejected', 'offer_rejected')
  end

  private

  def action(method, texto, notify, message_type)
    @offer.send(method)

    message = Message.new(text: texto, sendable: current_candidate,
                          message_type: message_type.to_sym)
    @offer.selection_process.messages << message

    OfferMailer.send(notify, @offer.id).deliver_now
    redirect_to selection_process_candidates_path(@selection_process)
  end

  def offer_params
    params.require(:offer).permit(:salary, :hiring_scheme, :start_date)
  end

  def set_variables
    @candidate = Candidate.find(params[:candidate_id])
    @selection_process = SelectionProcess.find(params[:selection_process_id])
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def new_offer
    return redirect_if_pending if pending_offer?

    return unless valid_date?

    @offer = Offer.new(offer_params) do |o|
      o.employee = current_employee
      o.message = Message.create(text: params[:offer][:message],
                                 sendable: current_employee,
                                 selection_process: @selection_process,
                                 message_type: :new_offer)
    end
  end

  def valid_date?
    day, month, year = params[:offer][:start_date].split '/'
    Date.valid_date? year.to_i, month.to_i, day.to_i
  end

  def pending_offer?
    @selection_process.offers.pending.any?
  end

  def redirect_if_pending
    flash[:notice] = 'Aguarde o retorno do candidato para poder realizar uma '\
                     'nova proposta'
    redirect_to selection_process_candidates_path(@selection_process)
  end
end
