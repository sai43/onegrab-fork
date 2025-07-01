class ApplicationController < ActionController::Base
  include Pagy::Backend

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_member!

  protected

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_path # You must define this route (e.g., /admin/dashboard)
    else
      stored_location_for(resource) || root_path
    end
  end  

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :phone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :phone])
  end

end
