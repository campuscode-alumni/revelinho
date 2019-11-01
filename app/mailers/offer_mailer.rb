class OfferMailer < ApplicationMailer
  def notify_candidate(offer_id)
    @offer = Offer.find(offer_id)
    @position = @offer.position
    @company = @offer.position.company
    subject = 'Você recebeu uma proposta para a posição ' +
              @offer.position.title

    mail(to: @offer.candidate.email, subject: subject)
  end

  def notify_accepted(offer_id)
    @offer = Offer.find(offer_id)
    notify_employee("Proposta aceita para #{@offer.position.title}")
  end

  def notify_rejected(offer_id)
    @offer = Offer.find(offer_id)
    notify_employee("Proposta recusada para #{@offer.position.title}")
  end

  private

  def notify_employee(subject)
    mail(to: @offer.employee.email, subject: subject)
  end
end
