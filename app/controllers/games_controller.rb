class GamesController < ApplicationController
  def index
    @games = Game.all
    if params[:query].present?
      @games = @games.where('title ILIKE ?', "%#{params[:query]}%")
    end

    respond_to do |format|
      format.html
      format.text { render partial: 'list.html', locals: { games: @games } }
    end
  end

  def show
    @game = Game.find(params[:id])
    @users = User.all
  end
end
