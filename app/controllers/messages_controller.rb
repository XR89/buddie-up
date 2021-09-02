class MessagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[create]
  # the above line is just to test that the chat functionality works during development without
  #  the hassle of logging in and out

  def create
    @gamesession = GameSession.find(params[:game_session_id])
    @message = Message.new(message_params)
    @message.session = @gamesession
    @message.user = current_user
    if @message.save
      redirect_to game_session_path(@gamesession, anchor: "message-#{@message.id}")
    else
      render "game_sessions/show"
    end
  end

  def message_params
    params.require(:message).permit(:content, :user_id, :game_session_id)
  end
end
