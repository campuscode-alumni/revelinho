class AddCandidateRefToInvite < ActiveRecord::Migration[6.0]
  def change
    add_reference :invites, :candidate, foreign_key: true
  end
end
