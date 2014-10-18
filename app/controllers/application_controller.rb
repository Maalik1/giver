class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  after_filter  :store_location

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
    devise_parameter_sanitizer.for(:accept_invitation) { |u| u.permit(:name, :password, :password_confirmation, :invitation_token) }
  end
  
  # Track user location
  def store_location
    if (request.fullpath != "/register" &&
        request.fullpath != "/login" &&
        request.fullpath != "/logout" &&
        !request.xhr?)
    
      if request.format == "text/html" || request.content_type == "text/html"
        session[:previous_url] = request.fullpath 
      end
    end
  end

  # Devise routing mods
  def after_sign_up_path_for(resource)
  	if resource.admin?
	    edit_org_path resource.orgs.first
	  else
	  	root_path
	  end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def after_invite_path_for(resource)
  	root_path
  end

  # Routing errors
  def not_found
	  raise ActionController::RoutingError.new('Not Found')
	end

	# Authorization Errors
  def authority_forbidden(error)
	  Authority.logger.warn(error.message)
	  redirect_to request.referrer.presence || root_path, :alert => 'You are not authorized to complete that action.'
	end

end
