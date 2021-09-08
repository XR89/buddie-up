class UsersController < ApplicationController
  before_action :find_avoided_users

  def profile
    @user = current_user
    @ratings = UserRating.where(reviewee_id: @user)
    @invitations = @user.invitations unless @user.invitations.nil?
  end

  def index
    @users = User.where.not(id: @avoided_users_array)


    if params[:query].present?
      @users = @users.where('username ILIKE ?', "%#{params[:query]}%")
    end

    respond_to do |format|
      format.html
      format.text { render partial: 'shared/userlist.html', locals: { users: @users } }
    end
  end

  def show
    @user = User.find(params[:id])
    @ratings = UserRating.where(reviewee_id: @user)
    @invitations = @user.invitations unless @user.invitations.nil?
    redirect_to profile_path if current_user == @user
    redirect_to profile_path if @avoided_users_array.include?(@user.id)


    @favourite_user = FavouriteUser.find_by(favourite_user: params[:id], user: current_user)
    @avoided_user = AvoidUser.find_by(avoid_user: params[:id], user: current_user)
  end

  private

  def find_avoided_users
      @avoided_users_array = current_user.avoid_users.map do |x|
      x.avoid_user_id
    end
  end
end
