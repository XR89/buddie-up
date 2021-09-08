class FavouriteUsersController < ApplicationController
  before_action :find_favourite
  def create
    @favourite_user = FavouriteUser.new
    @favourite_user.user = current_user
    @favourite_user.favourite_user = User.find(params[:user_id])
    if @favourite_user.save
      redirect_back(fallback_location: root_path)
    end

  end

  def destroy
    @favourite_user = FavouriteUser.find(@favourited_user.id)
    @favourite_user.destroy
    redirect_back(fallback_location: root_path)
      # render html: '<div>html goes here</div>'.html_safe
  end

  private

  def find_favourite
    @favourited_user = FavouriteUser.find_by(favourite_user: params[:user_id], user: current_user)
  end

  # def favourite_user_params
  #   params.require(:favourite_user).permit(:user_id)
  # end
end
