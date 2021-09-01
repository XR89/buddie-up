class AddRevieweeReferenceToUserReviewsTable < ActiveRecord::Migration[6.1]
  def change
    add_reference :user_ratings, :reviewee, foreign_key: { to_table: :users } 
  end
end
