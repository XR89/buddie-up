class RenameGameSessionIdToChatIdInMessages < ActiveRecord::Migration[6.1]
  def change
    remove_column :messages, :game_session_id, :bigint
    add_reference :messages, :chat, foreign_key: { to_table: :chats }, null: false
  end
end
