class OfferMailer < ApplicationMailer
  def notify_candidate(offer_id)
    @offer = Offer.find(offer_id)
    @position = @offer.position
    @company = @offer.position.company
    subject = "#{@offer.candidate.name}, você recebeu uma proposta para posiçã"\
              "o de #{@offer.position.title} na #{@offer.position.company.name}"

    mail(to: @offer.candidate.email, subject: subject)
  end
end
