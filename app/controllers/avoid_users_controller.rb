class AvoidUsersController < ApplicationController
  before_action :find_avoided_user
  skip_before_action :authenticate_user!

  def create
    @favourited_user = FavouriteUser.find_by(favourite_user: params[:user_id], user: current_user)
    @avoid_user = AvoidUser.new
    @avoid_user.user = current_user
    @avoid_user.avoid_user = User.find(params[:user_id])

    if @favourited_user
      @favourite_user_to_remove = FavouriteUser.find(@favourited_user.id)
      @favourite_user_to_remove.destroy
    end

    if @avoid_user.save
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @avoid_user = AvoidUser.find_by(avoid_user: params[:id])
    if @avoid_user.destroy
      redirect_back(fallback_location: root_path)
    end
      # render html: '<div>html goes here</div>'.html_safe
  end

  def index
    @avoided_users_instances = AvoidUser.where(user_id: current_user.id)
    if @avoided_users_instances[0]
      @avoided_users_array = @avoided_users_instances.map do |avoided_user|
        User.find(avoided_user.avoid_user_id)
      end
    end

    # if params[:query].present?
    #   @avoided_users_array = @avoided_users_array.where('username ILIKE ?', "%#{params[:query]}%")
    # end

    # respond_to do |format|
    #   format.html
    #   format.text { render partial: 'avoided_userlist.html', locals: { avoided_users: @avoided_users_array } }
    # end
  end



  private

  def find_avoided_user
    @avoided_user = AvoidUser.find_by(avoid_user: params[:user_id], user: current_user)
  end

# redirect above to home/profile so they dont have to see that dickhead again
end
