class AddAcceptedOrRejectedAtInviteToInvites < ActiveRecord::Migration[6.0]
  def change
    add_column :invites, :accepted_or_rejected_at, :datetime
  end
end
