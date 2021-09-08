class RenameGameSessionIdToChatIdInInvitations < ActiveRecord::Migration[6.1]
  def change
    remove_column :invitations, :game_session_id, :bigint
    add_reference :invitations, :chat, foreign_key: { to_table: :chats }, null: false
  end
end
