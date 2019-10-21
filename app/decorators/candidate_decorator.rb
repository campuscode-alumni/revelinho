class CandidateDecorator < SimpleDelegator
  def initialize(candidate)
    super(candidate)
  end

  def full_address
    "#{address}. #{city} - #{state}"
  end
end