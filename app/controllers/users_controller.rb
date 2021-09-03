class UsersController < ApplicationController
  def profile
    @user = current_user
    @invitations = @user.invitations unless @user.invitations.nil?
  end

  def index
    # if params[:query].present?
    #   @users = User.search_by_name(params[:query])
    # else
      @users = User.all
    # end
  end

  def show
    @user = User.find(params[:id])
    redirect_to profile_path if current_user == @user
  end
end
