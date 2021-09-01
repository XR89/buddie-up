class GamesController < ApplicationController
  def index
    # raise
    if params[:query].present?
      @test = params[:query]
      @test2 = @test['title']
      # raise
      @game = Game.find(@test2)
      redirect_to game_path(@game)
    else
      @games = Game.all
    end
  end

  def show
    @game = Game.find(params[:id])
  end
end
