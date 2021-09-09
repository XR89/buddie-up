class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    # newsfeed for logged in user
    @user = current_user
    redirect_to welcome_path, alert: 'Welcome! Please signup or login before continuing' unless current_user
  end

  def welcome
    # banner with call-to-action
    redirect_to root_path, notice: 'Welcome back!' if current_user
  end
end
