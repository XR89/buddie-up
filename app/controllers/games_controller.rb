class GamesController < ApplicationController
  def index
    # raise
    if params[:query].present?
      @game = params[:query]
      @game = Game.find(@game['title'])
      redirect_to game_path(@game)
    else
      @games = Game.all
    end
  end

  def show
    @game = Game.find(params[:id])
  end
end
