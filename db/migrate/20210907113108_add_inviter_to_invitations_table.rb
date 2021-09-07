class AddInviterToInvitationsTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :invitations, :inviter, foreign_key: { to_table: :users }, null: false
  end
end
