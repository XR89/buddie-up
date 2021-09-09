class UserRatingsController < ApplicationController
  before_action :find_reviewee, only: %i[new create]
  before_action :find_favourite

  def new
    @user_ratings = UserRating.where(user_id: current_user.id)
    if @user_ratings.where("user_id = ? AND reviewee_id = ?", current_user.id, @otheruser.id)[0]
      redirect_to chats_path, notice: "You have already reviewed this user"
    else
      @chat = Chat.find(params[:chat_id])
      @user_rating = UserRating.new
    end
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
      redirect_to new_chat_user_rating_path
    end
  end

  private

  def find_reviewee
    @users = User.all.select { |user| user.invitations.any? }
    @user_invitations = @users.map { |user| user.invitations }.flatten!
    @other_invitation = @user_invitations.select { |invitation| invitation.chat_id == params[:chat_id].to_i && invitation.user_id != current_user.id }[0]
    @otheruser = User.find(@other_invitation.user_id)
  end

  def find_favourite
    @favourite_user = FavouriteUser.find_by(favourite_user: @otheruser, user: current_user)
  end

  def rating_params
    params.require(:user_rating).permit(:rating, :comments, :reviewee_id, :user_id)
  end
end
