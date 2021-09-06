class FavouriteUsersController < ApplicationController
  def create
    @favourite_user = FavouriteUser.new
    @favourite_user.user = current_user
    @favourite_user.favourite_user = User.find(params[:id])
    @favourite_user.save!
    if @favourite_user.save
      redirect_back(fallback_location: root_path)
    end

  end

  def destroy
    @favourite_destroy = FavouriteUser.find_by favourite_user_id: params[:id]
    @favourite_destroy.destroy!
    if @favourite_user.nil?
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def favourite_user_params
    params.require(:favourite_user).permit(:user_id)
  end



end
