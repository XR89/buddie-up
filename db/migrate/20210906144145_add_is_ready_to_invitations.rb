class AddIsReadyToInvitations < ActiveRecord::Migration[6.1]
  def change
    add_column :invitations, :is_ready, :boolean
  end
end
