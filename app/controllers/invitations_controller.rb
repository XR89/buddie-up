class InvitationsController < ApplicationController
  def accept
    @invitation = Invitation.find(params[:id])
    @invitation.update(status: 'confirmed')
    @chat = Chat.find(@invitation.chat_id)
    redirect_to chat_path(@chat)
  end

  def decline
    @invitation = Invitation.find(params[:id])
    @invitation.update(status: 'declined')
    @invitation.chat.update(ongoing: false)
    redirect_back(fallback_location: profile_path)
  end
end
