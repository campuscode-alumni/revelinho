class CandidateNote < ApplicationRecord
  belongs_to :employee
  belongs_to :candidate
  enum visibility: { to_all: 0, hidden: 10 }
end
