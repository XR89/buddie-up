class CreateUserRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :user_ratings do |t|
      t.float :rating
      t.references :user, null: false, foreign_key: true
      t.text :comments
      t.integer :reviewer_id

      t.timestamps
    end
  end
end
