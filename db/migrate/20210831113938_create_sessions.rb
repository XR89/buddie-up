class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.boolean :ongoing
      t.string :status
      t.integer :users, array: true, default: []

      t.timestamps
    end
  end
end
