class MessagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[create]

  def create
    @gamesession = GameSession.find(params[:sessino_id])
    @message = Message.new(message_params)
    @message.session = @gamesession
    @message.user = current_user
    if @message.save
      redirect_to session_path(@gamesession, anchor: "message-#{@message.id}")
    else
      render "gamesessions/show"
    end
  end

  def message_params
    params.require(:message).permit(:content, :user_id, :game_session_id)
  end
end
