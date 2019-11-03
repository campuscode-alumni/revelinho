class AddMessageTypeToMessage < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :message_type, :integer, default: '0'
  end
end
