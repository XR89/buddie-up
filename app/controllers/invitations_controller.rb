class InvitationsController < ApplicationController
  skip_before_action :authenticate_user!
  def accept
    @invitation = Invitation.find(params[:id])
    @invitation.update(status: 'confirmed')
    @chat = Chat.find(@invitation.chat_id)
    redirect_to chat_path(@chat), notice: 'You have accepted the invitation and can now start chatting'
  end

  def decline
    @invitation = Invitation.find(params[:id])
    @invitation.update(status: 'declined')
    @invitation.chat.update(ongoing: false)
    # redirect_toback(fallback_location: profile_path)
    redirect_to profile_path, notice: 'You have declined the invitation'
  end
end
