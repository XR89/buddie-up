class RenameSessionsTableToGameSessionsTable < ActiveRecord::Migration[6.1]
  def change
    rename_table :sessions, :game_sessions
  end
end
