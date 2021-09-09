class ChatsController < ApplicationController

  def index
    @all_user_invitations = Invitation.where("inviter_id = ? OR user_id = ?", current_user.id, current_user.id)
    @invitations = @all_user_invitations.reject { |invitation| invitation.inviter_id == invitation.user_id }
    # returns all invitations that have ongoing = true and inviter not user id
  end

  def show
    @chat = Chat.find(params[:id])
    @invitation = current_user.invitations.where(chat: params[:id])[0] unless current_user.invitations.nil?
    if @invitation.nil? || @invitation.status != 'confirmed'
      redirect_to profile_path, alert: "You don't have access to that chat" # add error message, not final.
    elsif @chat.ongoing == false
      # flash[:notice] = "You can now rate users"
      redirect_to new_chat_user_rating_path(@chat), notice: 'You can now rate users'
      # flash.keep(:notice)
    else
      @message = Message.new
    end
  end

  def create
    # Whenever a user creates a chat , chat ongoing -> true, invitation for user -> confirmed
    # When the user accepts -> invitation is confirmed
    @chat = Chat.new
    @chat.ongoing = true
    @invitation_1 = Invitation.new(status: 'confirmed') # for first user who initiaties the chat
    @invitation_1.user = current_user
    @invitation_1.inviter = current_user
    @invitation_1.chat = @chat
    # @chat.status = 'new'
    redirect_to profile_path, alert: 'An error happened. Please try again' unless @invitation_1.save # flash error message

    @invitee = User.find(params[:user_id]) # assuming we are on user's show page or game's show page(user card)
    # for user_2 to decide whether to accept
    @invitation_2 = Invitation.new(status: 'unconfirmed')
    @invitation_2.user = @invitee
    @invitation_2.inviter = current_user
    @invitation_2.chat = @chat

    # @game = Game.find(params[:id])
    # @chat.game = @game
    if @invitation_1.save && @invitation_2.save && @chat.save
      redirect_to chat_path(@chat), notice: "You can now start chatting"
    else
      redirect_to profile_path, alert: "An error happened. Please try again"
    end
  end

  def end_chat
    @chat = Chat.find(params[:id])
    @chat.update(ongoing: false)

    @all_users_invitations = Invitation.where(chat_id: params[:id].to_i) # this returns an array of invitations per chat
    @users_unconfirmed = @all_users_invitations.where(status: 'unconfirmed')
    @users_declined = @all_users_invitations.where(status: 'declined')

    if @all_users_invitations.all? { |invitation| invitation.status == 'confirmed' }
      redirect_to new_chat_user_rating_path(@chat), notice: "You can now rate users"
    elsif @users_unconfirmed.present?
      @users_unconfirmed.first.update(status: 'declined')
      redirect_to root_path, notice: 'Chat has ended.'
    elsif @users_declined.first.present?
      redirect_to root_path, notice: 'It seems the other user has declined your invitation'
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:ongoing, :status)
  end
end
