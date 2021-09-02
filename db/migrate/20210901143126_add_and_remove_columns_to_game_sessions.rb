class AddAndRemoveColumnsToGameSessions < ActiveRecord::Migration[6.1]
  def change
    add_reference :game_sessions, :game, foreign_key: { to_table: :games }
    remove_column :game_sessions, :users
  end
end
