class UsersController < ApplicationController
  def profile
    @user = current_user
    @ratings = UserRating.where(reviewee_id: @user)
    @invitations = @user.invitations unless @user.invitations.nil?
  end

  def index
    @users = User.all

    if params[:query].present?
      @users = @users.where('username ILIKE ?', "%#{params[:query]}%")
    end

    respond_to do |format|
      format.html
      format.text { render partial: 'games/userlist.html', locals: { users: @users } }
    end
  end

  def show
    @user = User.find(params[:id])
    @ratings = UserRating.where(reviewee_id: @user)
    @invitations = @user.invitations unless @user.invitations.nil?
    redirect_to profile_path if current_user == @user
  end
end
