class AddSessionsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :session, foreign_key: true
  end
end
