class AddSendableToMessages < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :sendable, polymorphic: true
  end
end
