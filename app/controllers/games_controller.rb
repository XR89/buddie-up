class GamesController < ApplicationController
  def index
    # raise
    if params[:query].present?
      @game = params[:query]
      if @game['title'].present?
        @game = Game.find(@game['title'])
        redirect_to game_path(@game)
      else
        @games = Game.all
      end
    else
      @games = Game.all
    end
  end

  def show
    @game = Game.find(params[:id])
  end
end
