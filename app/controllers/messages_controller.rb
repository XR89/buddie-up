class MessagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[create]
  # the above line is just to test that the chat functionality works during development without
  #  the hassle of logging in and out

  def create
    # raise
    @gamesession = GameSession.find(params[:game_session_id])
    @message = Message.new(message_params)
    @message.game_session = @gamesession
    @message.user = current_user
    # raise
    if @message.save
      GameSessionChannel.broadcast_to(
        @gamesession,
        render_to_string(partial: "message", locals: { message: @message })
      )
      redirect_to game_session_path(@gamesession, anchor: "message-#{@message.id}")
    else
      render "game_sessions/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
