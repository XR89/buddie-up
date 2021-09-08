class UserRatingsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new]
  before_action :find_reviewee
  before_action :find_favourite

  def new
    @user_rating = UserRating.new
    @gamesession = GameSession.find(params[:game_session_id])
  end

  def create
    @user_rating = UserRating.new(rating_params)
    @user_rating.reviewee_id = @otheruser.id
    @user_rating.user_id = current_user.id
    if @user_rating.save
      all_user_ratings = UserRating.where(reviewee_id: @otheruser.id)
      average_rating_array = all_user_ratings.map { |rating| rating.rating }
      calculated_average_rating = (average_rating_array.sum) / ( average_rating_array.length.zero? ? 1 : average_rating_array.length )
      @otheruser.update(average_rating: calculated_average_rating)

      redirect_to user_path(@otheruser)
    else
      render :new
    end
  end

  private

  def find_reviewee
    @users = User.all.select { |user| user.invitations.any? }
    @user_invitations = @users.map { |user| user.invitations }.flatten!
    @other_invitation = @user_invitations.select { |invitation| invitation.game_session_id == params[:game_session_id].to_i  && invitation.user_id != current_user.id }[0]
    @other_user = User.find(@other_invitation.user_id)
  end

  def find_favourite
    @favourite_user = FavouriteUser.find_by(favourite_user: @otheruser, user: current_user)
  end

  def rating_params
    params.require(:user_rating).permit(:rating, :comments, :reviewee_id, :user_id)
  end

end
