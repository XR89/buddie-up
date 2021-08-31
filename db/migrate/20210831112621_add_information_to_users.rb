class AddInformationToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :email, :string
    add_column :users, :username, :string
    add_column :users, :password, :string
    add_column :users, :region, :string
    add_column :users, :dob, :date
    add_column :users, :gender, :string
    add_column :users, :language, array: true, default: []
    add_column :users, :steam_handle, :string
    add_column :users, :origin_handle, :string
    add_column :users, :psn_handle, :string
    add_column :users, :epic_handle, :string
    add_column :users, :discord_handle, :string
    add_column :users, :live_handle, :string
    add_column :users, :gog_handle, :string
    add_column :users, :twich_handle, :string
    add_column :users, :battlenet_handle, :string
    add_column :users, :session_id, :references
    add_column :users, :favourite_games, :string, array: true, default: []
    add_column :users, :favourite_users, :integer, array: true, default: []
    add_column :users, :avoid_users, :integer, array: true, default: []
    add_column :users, :user_status, :integer
  end
end
