class AddSessionsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :session, null: false, foreign_key: true
  end
end
