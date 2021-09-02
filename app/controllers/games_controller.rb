class GamesController < ApplicationController
  def index
    # raise
    if params[:query].present?
      @game_param = params[:query]
      @game = Game.find(@game_param['title'])
      redirect_to game_path(@game)
    else
      @games = Game.all
    end
  end

  def show
    @game = Game.find(params[:id])
  end
end
