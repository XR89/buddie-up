class UserRatingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new]
  before_action :find_reviewee
  def new
    @user_rating = UserRating.new
    # raise
    # @gamesession = GameSession.find(params[:game_session_id])
    @gamesession = GameSession.find(params[:game_session_id])
  end

  def create
    @user_rating = UserRating.new(rating_params)
    @user_rating.reviewee_id = @otheruser.id
    @user_rating.user_id = current_user.id
    if @user_rating.save!
      redirect_to user_path(@otheruser)
    else
      render :new
    end
  end

  private

  def find_reviewee
    @users = User.all.select { |user| user.invitations.any? }
    @otheruser = @users.select { |user| user.invitations.last.game_session_id == params[:game_session_id].to_i && user.id != current_user.id }[0]
  end

  def rating_params
    params.require(:user_rating).permit(:rating, :comments, :reviewee_id, :user_id)
  end
end
