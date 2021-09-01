class AddFavouriteUsertoFavouriteUsersTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :favourite_users, :favourite_user, foreign_key: { to_table: :users } 
  end
end
