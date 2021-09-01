class GameSessionsController < ApplicationController

  def show
    @gamesession = GameSession.find(params[:id])
  end
end
