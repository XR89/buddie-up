class UserRatingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new]
  def new
    @user_rating = UserRating.new
    # raise
  end

  def create
    @user_rating = UserRating.new(rating_params)
    @user_rating.user = User.find(params[:user_id])
    if @user_rating.save!
      redirect_to user_path(@user_rating)
    else
      render :new
    end
  end

  private

  def rating_params
    params.require(:user_rating).permit(:rating, :comments, :reviewer_id, :user_id)
  end
end
