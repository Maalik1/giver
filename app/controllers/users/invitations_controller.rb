class Users::InvitationsController < Devise::InvitationsController

  before_action :check_user_privileges, only: [:new, :create] 

  def new
    self.resource = resource_class.new
    render :new
  end

  # POST /resource/invitation
  def create
    self.resource = invite_resource
    if resource.errors.empty?
      resource.creds.create(org_id: @org.id, status: params[:admin_status])
      yield resource if block_given?
      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, :email => self.resource.email
      end
      respond_with resource, :location => after_invite_path_for(resource)
    else
      respond_with_navigational(resource) { render :new }
    end
  end

private
	
  def check_user_privileges
    @org = Org.find_by_slug(params[:org]) || not_found
    unless current_user.creds_for? @org, :admin
      redirect_to session[:previous_url] || root_path, :alert => 'You are not authorized to complete that action.'
    end
  end

end