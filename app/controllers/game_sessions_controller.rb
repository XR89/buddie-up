class GameSessionsController < ApplicationController
  # skip_before_action :authenticate_user!, only: %i[show]
  # the above line is just to test that the chat functionality works during development without
  #  the hassle of logging in and out

  def show
    @gamesession = GameSession.find(params[:id])
    @message = Message.new
  end
  # new should be in the game show page as a button to create a new game session.

  def create
    @gamesession = GameSession.new(gamesession_params)
    # @gamesession.ongoing = true
    # @gamesession.status = 'active'
    # @game = Game.find(params[:id])
    # @gamesession.game = @game
    if @gamesession.save
      redirect_to game_session_path(@gamesession)
    else
      render root_path
    end
  end

  private

  def gamesession_params
    params.require(:gamesession).permit(:ongoing, :status)
  end
end
