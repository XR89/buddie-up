class FavouriteGamesController < ApplicationController
  skip_before_action :authenticate_user!
  def create
    @favourite_game = FavouriteGame.new
    @favourite_game.user = current_user
    @favourite_game.game = Game.find(params[:game_id])
    if @favourite_game.save
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @favourite_game = FavouriteGame.find(params[:id])
    @favourite_game.destroy
    redirect_back(fallback_location: root_path)
    # render html(javascript): '<div>html goes here</div>'.html_safe
  end
end
