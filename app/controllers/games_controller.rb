class GamesController < ApplicationController
  def index
    @games = Game.all

    if params[:query].present?
      @games = @games.where('title ILIKE ?', "%#{params[:query]}%")
    end

    respond_to do |format|
      format.html
      format.text { render partial: 'gamelist.html', locals: { games: @games } }
    end
  end

  def show
    @game = Game.find(params[:id])
    @users = User.all
    @avoided_users_array = current_user.avoid_user_ids
    # @passed_users = @users.reject
  end
end
