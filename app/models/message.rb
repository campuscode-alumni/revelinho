class Message < ApplicationRecord
  belongs_to :selection_process

  belongs_to :sendable, polymorphic: true
end
