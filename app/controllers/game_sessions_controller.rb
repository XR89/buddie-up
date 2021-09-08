class GameSessionsController < ApplicationController

  def show
    @gamesession = GameSession.find(params[:id])
    @invitation = current_user.invitations.where(game_session: params[:id])[0] unless current_user.invitations.nil?
    if @invitation.nil? || @invitation.status != 'confirmed' || @gamesession.ongoing == false
      redirect_to profile_path # add error message, not final.
    else
      @message = Message.new
    end
  end

  def index
    @user = current_user
    @invitations = current_user.invitations.select { |invitation| invitation.game_session.ongoing != false}
    # returns all invitations for gamesessions that have ongoing = true
  end

  def create
    # Whenever a user creates a chat , gamesession ongoing -> true, invitation for user -> confirmed
    # When the user accepts -> invitation is confirmed
    @gamesession = GameSession.new
    @gamesession.ongoing = true
    @invitation_1 = Invitation.new(status: 'confirmed') # for first user who initiaties the chat
    @invitation_1.user = current_user
    @invitation_1.inviter = current_user
    @invitation_1.game_session = @gamesession
    # @gamesession.status = 'new'
    redirect_to profile_path unless @invitation_1.save # flash error message

    @invitee = User.find(params[:user_id]) # assuming we are on user's show page or game's show page(user card)
    # for user_2 to decide whether to accept
    @invitation_2 = Invitation.new(status: 'unconfirmed')
    @invitation_2.user = @invitee
    @invitation_2.inviter = current_user
    @invitation_2.game_session = @gamesession

    # @game = Game.find(params[:id])
    # @gamesession.game = @game
    if @invitation_1.save && @invitation_2.save && @gamesession.save
      redirect_to game_session_path(@gamesession)
    else
      redirect_to profile_path
    end
  end

  # def start_game_session
  #   @current_user_invitation = current_user.invitations.where(game_session_id: params[:id].to_i)[0]
  #   @current_user_invitation.update(is_ready: true)

  #   @invitations = Invitation.where("game_session_id = ? AND status = ?", params[:id].to_i, 'confirmed') # array
  #   if @invitations.all? { |invitation| invitation.is_ready == true }
  #     GameSession.find(params[:id]).update(ongoing: true)
  #   end

  #   @invitations = Invitation.where("game_session_id = ? AND status = ?", params[:id].to_i, 'unconfirmed') # array
  #   @invitations.each { |invitation| invitation.update(status: 'declined') } # for people who haven't accept the invite
  # end

  def end_game_session
    @gamesession = GameSession.find(params[:id])
    @gamesession.update(ongoing: false)

    @all_users_invitations = Invitation.where(game_session_id: params[:id].to_i) # this returns an array of invitations per gamesession
    @users_unconfirmed = @all_users_invitations.where(status: 'unconfirmed')
    @users_declined = @all_users_invitations.where(status: 'declined')

    if @all_users_invitations.all? { |invitation| invitation.status == 'confirmed' }
      redirect_to new_game_session_user_rating_path(@gamesession)
    elsif @users_unconfirmed.present?
      @users_unconfirmed.first.update(status: 'declined')
      redirect_to root_path
    elsif @users_declined.first.present?
      redirect_to root_path
    end
  end



    # if current_user_status == 'left' && @other_user.status == 'unconfirmed'
    #   @other_user.update(status: 'declined')
    # end

    # @remaining_users = Invitation.where(game_session_id: params[:id].to_i)
    # if @remaining_users.where(status: 'confirmed').count <= 1
    #   @remaining_users.first.update(status: 'left')
    #   @gamesession.update(status: 'dead')
    #   # @reviewable_users.first.invitations.last.update(status: 'left')
    # end

    # if @gamesession.ongoing == true
    #   redirect_to new_game_session_user_rating_path(@gamesession)
    # else
    #   redirect_to root_path
    # end


    # @users = User.all.select { |user| user.invitations.any? }
    # @user_invitations = user.invitations.where(game_session_id: params[:id].to_i)
    # @users_left = @users.select do |user|
    #   return true if @user_invitations[0].status == 'confirmed'
    # end

  private

  def gamesession_params
    params.require(:gamesession).permit(:ongoing, :status)
  end
end
