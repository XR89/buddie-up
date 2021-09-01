class GameSessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  def show
    @gamesession = GameSession.find(params[:id])
  end
end
