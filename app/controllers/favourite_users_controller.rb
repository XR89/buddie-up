class FavouriteUsersController < ApplicationController
  def create
    @favourite_user = FavouriteUser.new()

  end

  def destroy
  end

  private

  def favourite_user_params
    params.require(:favourite_user).permit(:user_id, :favourite_user_id)
  end
end
