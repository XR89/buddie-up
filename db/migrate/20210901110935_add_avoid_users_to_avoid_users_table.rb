class AddAvoidUsersToAvoidUsersTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :avoid_users, :avoid_user, foreign_key: { to_table: :users }
  end
end
