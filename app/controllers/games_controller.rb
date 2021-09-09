class GamesController < ApplicationController
  before_action :find_avoided_users, only: :show
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
    @users = User.where.not(id: @current_user_avoided_users_array | @users_avoiding_current_user)
    @favourite_game = FavouriteGame.find_by(game: @game, user: current_user)
  end

  private

  def find_avoided_users
    @current_user_avoided_users_array = current_user.avoid_users.map do |x|
      x.avoid_user_id
    end
    @avoid_instances_with_current_user = AvoidUser.where(avoid_user_id: current_user.id)
    @users_avoiding_current_user = @avoid_instances_with_current_user.map do |avoid_user_instances|
      avoid_user_instances.user_id
    end
  end

  def users_favourite_games(user_id)
    favourited_array = FavouriteGame.where(user_id: user_id)
    favourite_game_ids = favourited_array.map { |instance| instance.game_id }
  end
end
