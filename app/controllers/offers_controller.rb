class OffersController < ApplicationController
  before_action :set_candidate, only: %i[new create]
  before_action :set_selection_process, only: %i[new create]
  before_action :new_offer, only: %i[create]

  def new; end

  def create
    if @selection_process.offers << @offer
      OfferMailer.notify_candidate(@offer.id).deliver_now
      return redirect_to selection_process_candidates_path(@selection_process)
    end

    render :new
  end

  private

  def offer_params
    params.require(:offer).permit(:salary, :hiring_scheme, :start_date)
  end

  def set_candidate
    @candidate = Candidate.find(params[:candidate_id])
  end

  def set_selection_process
    @selection_process = SelectionProcess.find(params[:selection_process_id])
  end

  def new_offer
    @offer = Offer.new(offer_params) do |o|
      o.employee = current_employee
      o.message = Message.create(text: params[:message],
                                 sendable: current_employee,
                                 selection_process: @selection_process)
    end
  end
end
