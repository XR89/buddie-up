class MessagesController < ApplicationController
  def create
    @session = Session.find(params[:sessino_id])
    @message = Message.new(message_params)
    @message.session = @session
    @message.user = current_user
    if @message.save
      redirect_to session_path(@session, anchor: "message-#{@message.id}")
    else
      render "sessions/show"
    end
  end

  def message_params
    params.require(:message).permit(:content, :user_id, :session_id)
  end
end
