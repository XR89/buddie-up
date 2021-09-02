class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :dob, :gender, :region])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :dob, :gender, :region,
                                                              :steam_handle, :origin_handle,
                                                              :psn_handle, :epic_handle,
                                                              :discord_handle, :live_handle,
                                                              :gog_handle, :twich_handle,
                                                              :battlenet_handle])
  end
end
