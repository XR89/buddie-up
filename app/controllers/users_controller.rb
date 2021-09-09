class UsersController < ApplicationController
  before_action :find_avoided_users

  def profile
    @user = current_user
    @ratings = UserRating.where(reviewee_id: @user)
    @invitations = @user.invitations unless @user.invitations.nil?
    @favourite_games = users_favourite_games(current_user.id)
  end

  def index
    @users = User.where.not(id: @current_user_avoided_users_array)
    @favourite_users = current_user.favourite_users
    @favourite_user_ids = @favourite_users.map { |user| user.id}

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
    @favourite_games = users_favourite_games(@user.id)
    redirect_to profile_path if current_user == @user
    redirect_to profile_path if @current_user_avoided_users_array.include?(@user.id)
    redirect_to profile_path if @user.avoid_user_ids.include?(current_user.id)
    @favourite_user = FavouriteUser.find_by(favourite_user: params[:id], user: current_user)
    @avoided_user = AvoidUser.find_by(avoid_user: params[:id], user: current_user)
  end

  private

  def find_avoided_users
    @current_user_avoided_users_array = current_user.avoid_users.map do |x|
      x.avoid_user_id
    end

  end

  def users_favourite_games(user_id)
    favourited_array = FavouriteGame.where(user_id: user_id)
    favourite_game_ids = favourited_array.map { |instance| instance.game_id }
    favourite_game_ids.map { |id| Game.find(id) }
  end



end
