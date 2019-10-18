class AddPositionRefToInvite < ActiveRecord::Migration[6.0]
  def change
    add_reference :invites, :position, foreign_key: true
  end
end
