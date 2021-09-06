class UsersController < ApplicationController
  def profile
    @user = current_user
    @invitations = @user.invitations unless @user.invitations.nil?
  end

  def index
    # @users = User.all
    @avoided_users_array = current_user.avoid_users.map do |x|
      x.avoid_user_id
    end
    @users = User.where.not(id: @avoided_users_array)


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
    redirect_to profile_path if current_user == @user
  end
end
