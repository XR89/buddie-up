class AvoidUsersController < ApplicationController
  def create
    @avoid_user = AvoidUser.new
    @avoid_user.user = current_user
    @avoid_user.avoid_user = User.find(params[:user_id])
    @avoid_user.save!
  if @avoid_user.save
    redirect_back(fallback_location: root_path)


    # redirect above to home/profile so they dont have to see that dickhead again
  end

  end
end
