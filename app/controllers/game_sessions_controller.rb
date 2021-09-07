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
    if current_user.invitations.any? && current_user.invitations.last.status == 'confirmed'
      @gamesession = GameSession.find(current_user.invitations.last.game_session_id)
    else
      @gamesession = GameSession.new
      @invitation_1 = Invitation.new(status: 'confirmed') # for first user who initiaties the chat
      @invitation_1.user = current_user
      @invitation_1.inviter = current_user
      @invitation_1.game_session = @gamesession
      @gamesession.ongoing = false
      @gamesession.status = 'new'
      redirect_to profile_path unless @invitation_1.save # flash error message
    end

    @invitee = User.find(params[:user_id]) # assuming we are on user's show page.
    # for user_2 to decide whether to accept
    @invitation_2 = Invitation.new(status: 'unconfirmed')
    @invitation_2.user = @invitee
    @invitation_2.inviter = current_user
    @invitation_2.game_session = @gamesession

    # @game = Game.find(params[:id])
    # @gamesession.game = @game
    if @gamesession.save && @invitation_2.save
      redirect_to game_session_path(@gamesession)
    else
      redirect_to profile_path
    end
  end

  def start_game_session
    @current_user_invitation = current_user.invitations.where(game_session_id: params[:id].to_i)[0]
    @current_user_invitation.update(is_ready: true)

    @invitations = Invitation.where("game_session_id = ? AND status = ?", params[:id].to_i, 'confirmed') # array
    if @invitations.all? { |invitation| invitation.is_ready == true }
      GameSession.find(params[:id]).update(ongoing: true)
    end

    @invitations = Invitation.where("game_session_id = ? AND status = ?", params[:id].to_i, 'unconfirmed') # array
    @invitations.each { |invitation| invitation.update(status: 'declined') } # for people who haven't accept the invite
  end

  def end_game_session
    @gamesession = GameSession.find(params[:id])
    # if gamesession was true, chat becomes 'dead', redirect users to reviews page.
    # set invitation to 'left'
    current_user_invitation = current_user.invitations.where(game_session_id: params[:id].to_i)[0] #array of one
    current_user_invitation.update(status: 'left')
    if @gamesession.ongoing == true
      redirect_to new_game_session_user_rating_path(@gamesession)
    else
      # if gamesession never becomes true, then chat becomes 'dead', don't redirect users to reviews page.
      # set invitation to 'left'
      redirect_to root_path
    end

    # @users = User.all.select { |user| user.invitations.any? }
    # @user_invitations = user.invitations.where(game_session_id: params[:id].to_i)
    # @users_left = @users.select do |user|
    #   return true if @user_invitations[0].status == 'confirmed'
    # end

    @remaining_users = Invitation.where(game_session_id: params[:id].to_i)
    if @remaining_users.where(status: 'confirmed').count <= 1
      @remaining_users.first.update(status: 'left')
      @gamesession.update(status: 'dead')
      # @reviewable_users.first.invitations.last.update(status: 'left')
    end
  end

  private

  def gamesession_params
    params.require(:gamesession).permit(:ongoing, :status)
  end
end
