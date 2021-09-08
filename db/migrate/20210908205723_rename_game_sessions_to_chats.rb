class RenameGameSessionsToChats < ActiveRecord::Migration[6.1]
  def change
    rename_table :game_sessions, :chats
  end
end
