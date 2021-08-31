class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.references :game_id, null: false, foreign_key: true
      t.boolean :ongoing
      t.string :status
      t.array :users

      t.timestamps
    end
  end
end
