class InvitationsController < ApplicationController

  # def update
  #   @invitation = Invitation.find(params[:id])
  # end

  def accept
    @invitation = Invitation.find(params[:id])
    @invitation.update(status: 'confirmed')
    redirect_to game_session_path(@invitation.game_session_id)
  end

  def decline
    @invitation = Invitation.find(params[:id])
    @invitation.update(status: 'declined')
    redirect_to profile_path
  end
end
