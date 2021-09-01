class RemoveReviewerIdFromUserRatings < ActiveRecord::Migration[6.1]
  def change
    remove_column :user_ratings, :reviewer_id, :integer
  end
end
