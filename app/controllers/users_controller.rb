class UsersController < ApplicationController
  def profile
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    redirect_to profile_path if current_user == @user
  end
end
