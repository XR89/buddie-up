class GameSessionsController < ApplicationController
  # skip_before_action :authenticate_user!, only: %i[show]
  # the above line is just to test that the chat functionality works during development without
  #  the hassle of logging in and out

  def show
    @invitation = current_user.invitations.where(game_session: params[:id])[0] unless current_user.invitations.nil?
    if @invitation.nil? || @invitation.status != 'confirmed'
      redirect_to profile_path # add error message, not final.
    else
      @gamesession = GameSession.find(params[:id])
      @message = Message.new
    end
  end
  # new should be in the game show page as a button to create a new game session.

  def create
    @gamesession = GameSession.new # not yet testing for existence for game session.

    @invitation_1 = Invitation.new(status: 'confirmed') # for first user who initiaties the chat
    @invitation_1.user = current_user
    @invitation_1.game_session = @gamesession

    @invitee = User.find(params[:user_id]) # assuming we are on user's show page.
    # for user_2 to decide whether to accept
    @invitation_2 = Invitation.new(status: 'unconfirmed')
    @invitation_2.user = @invitee
    @invitation_2.game_session = @gamesession

    @gamesession.ongoing = true
    # @gamesession.status = 'active'
    # @game = Game.find(params[:id])
    # @gamesession.game = @game
    if @gamesession.save && @invitation_1.save && @invitation_2.save
      redirect_to game_session_path(@gamesession)
    else
      redirect_to profile_path
    end
  end

  def end_game_session
    current_user.invitations.last.update(status: 'left')
    # need to check how many users are left
    @users = User.all.select { |user| user.invitations.any? }
    @users_left = @users.select do |user|
      user.invitations.last.game_session_id == params[:id].to_i && (user.invitations.last.status == 'confirmed' || user.invitations.last.status == 'unconfirmed')
    end
    raise
    # if one user left, set their invitation to left and game sesion ongoing to false
    @gamesession = GameSession.find(params[:id])
    if @users_left.count == 1
      @gamesession.ongoing = false
      @users_left.first.invitations.last.update(status: 'left')
    end
    redirect_to new_game_session_user_rating_path(@gamesession)
  end

  private

  def gamesession_params
    params.require(:gamesession).permit(:ongoing, :status)
  end
end
