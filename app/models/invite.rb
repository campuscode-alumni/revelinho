class Invite < ApplicationRecord
  belongs_to :position
  belongs_to :candidate
end
