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
    @avoided_users_array = current_user.avoid_users.map do |x|
      x.avoid_user_id
    end
    @users = User.where.not(id: @avoided_users_array)
    # @users = User.reject
    @favourite_game = FavouriteGame.find_by(game: @game, user: current_user)
  end
end
