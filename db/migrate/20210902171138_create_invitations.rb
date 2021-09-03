class CreateInvitations < ActiveRecord::Migration[6.1]
  def change
    create_table :invitations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game_session, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
