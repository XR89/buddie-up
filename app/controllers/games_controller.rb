class GamesController < ApplicationController
  def index
    @games = Game.all
    if params[:query].present?
      @games = @games.where('title ILIKE ?', "%#{params[:query]}%")
      # this will return what the user searched in an array
    end
    @favourite_games = users_favourite_games(current_user.id)
    # this will return an array of favourite game ids [1,2]

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
    @users.each do |x|
      x.avoid_users.each do |y|
        @avoided_users_array << y.avoid_user_id if y.avoid_user_id == current_user.id
      end
    end
  end

  private

  def users_favourite_games(user_id)
    favourited_array = FavouriteGame.where(user_id: user_id)
    favourite_game_ids = favourited_array.map { |instance| instance.game_id }
  end
end
