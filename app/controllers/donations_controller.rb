class DonationsController < PrivateController

  before_action :set_project
  before_action :set_reward, only: [:payment, :create]
  before_action :set_amount, only: [:payment]
  before_action :set_donation, only: [:show]
  
  def index; end

  def show; end

  def new; end

  def payment
    @donation = @project.donations.new
  end
  
  def create 
    if user_signed_in?
      DonationsWorker.perform_async(current_user.id, @project.id, @reward.id, params[:token], params[:amount])
      flash[:notice] = 'Your donation has been placed. Thank you for helping.'
      redirect_to @project
    else
      if params[:token].present? && params[:email].present?
        new_user = User.create_from_email(params[:email])
        if new_user
          DonationsWorker.perform_async(new_user.id, @project.id, @reward.id, params[:token], params[:amount])
          sign_in(:user, new_user)
          flash[:notice] = 'Your donation has been placed. Thank you for helping.'
          redirect_to @project
        else
          flash[:alert] = 'There was a problem with your email. Please log in if you already have an account.'
          redirect_to :back
        end
      else 
        flash[:alert] = 'Please make sure that you\'ve provided all needed information.'
        redirect_to :back
      end
    end
  end

private

  def set_project
    @project = Project.find_by_slug(params[:project_id]) || not_found
  end

  def set_reward
    @reward = @project.rewards.find_by_uuid(params[:reward])
    unless @reward
      redirect_to :back, :alert => 'Please select a reward'
    end
  end

  def set_amount
    if params.has_key?(:amount) && params[:amount].present?
      @amount = params[:amount]
      unless @reward.donation_valid?(@amount)
        redirect_to :back, :alert => "Donation does not qualify for this reward"
      end
    else
      @amount = @reward.amount
    end
  end

  def set_donation
    @donation = @project.donations.find(params[:id]) || not_found
    authorize_action_for @donation
  end

  def donation_params
    params.require(:donation).permit(:project_id, :user_id, :reward_id, :amount)
  end

end