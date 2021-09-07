class AddStatusToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :tagline, :string
  end
end
