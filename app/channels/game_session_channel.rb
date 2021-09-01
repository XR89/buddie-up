class GameSessionChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    gamesession = GameSession.find(params[:id])
    stream_for gamesession
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
