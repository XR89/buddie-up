class InvitationsController < ApplicationController

  # def update
  #   @invitation = Invitation.find(params[:id])
  # end

  def accept
    @invitation = Invitation.find(params[:id])
    @invitation.update(status: 'confirmed')
    @gamesession = GameSession.find(@invitation.game_session_id)
    # if @gamesession.status == 'new'
    #   @gamesession.update(status: 'active')
    # end
    redirect_to game_session_path(@gamesession)
  end

  def decline
    @invitation = Invitation.find(params[:id])
    @invitation.update(status: 'declined')
    redirect_to profile_path
  end
end
