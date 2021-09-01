class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    # newsfeed for logged in user
    redirect_to welcome_path unless current_user
  end

  def welcome
    # banner with call-to-action
    redirect_to root_path if current_user
  end
end
