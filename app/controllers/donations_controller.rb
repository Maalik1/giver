class DonationsController < ApplicationController

  before_action :authenticate_user!,  only: [:show]
  before_action :set_donation,        only: [:show]
  before_action :set_project
  before_action :set_reward,          only: [:payment, :create]
  before_action :set_amount,          only: [:payment]
  before_action :check_customer_card, only: [:payment]

  layout 'project'
  
  def index; end

  def show; end

  def new; end

  def payment
    @donation = @project.donations.new
  end
  
  def create 
    # render text: params.inspect
    if user_signed_in?
      donor = current_user
    else
      if params[:email].present?
        new_user = User.create_from_name_and_email(params[:name], params[:email])
        if new_user
          donor = new_user
          sign_in(:user, new_user)
        else
          flash[:alert] = 'There was a problem with your email. Please log in if you already have an account.'
          redirect_to :back
        end
      else 
        flash[:alert] = 'Please make sure that you\'ve provided all needed information.'
        redirect_to :back
      end
    end
    
    if donor and params.has_key?(:token)
      reward_id = (@reward) ? @reward.id : nil 
      anonymous = (params[:anonymous]) ? true : false 

      DonationsWorker.perform_async(
        user_id:    donor.id,
        project_id: @project.id, 
        card_token: params[:token],
        amount:     params[:amount],
        reward_id:  reward_id,
        anonymous:  anonymous
      )

      flash[:notice] = 'Your donation has been placed. Thank you for helping.'
      redirect_to @project
    end
  end

private

  def set_project
    @project = Project.find_by_slug(params[:project_id]) || not_found
  end

  def set_reward
    @reward = @project.rewards.find_by_uuid(params[:reward])
  end

  def set_amount
    if @reward
      if params.has_key?(:amount) and params[:amount].present?
        @amount = params[:amount]
        unless @reward.donation_valid?(@amount)
          redirect_to :back, alert: "Donation amount does not qualify for that reward"
        end
      else
        @amount = @reward.amount
      end
    else
      if params.has_key?(:amount) and params[:amount].present?
        @amount = params[:amount]
      else
        redirect_to :back, alert: "Please select an amount"
      end
    end
  end

  def check_customer_card
    if user_signed_in? and current_user.is_customer?
      @customer = Stripe::Customer.retrieve(current_user.stripe_id)
      @card = (@customer) ? @customer.cards.retrieve(@customer.default_card) : nil
    end
    @card ||= nil
  end

  def set_donation
    @donation = @project.donations.find(params[:id]) || not_found
    authorize_action_for @donation
  end

  def donation_params
    params.require(:donation).permit(:project_id, :user_id, :reward_id, :amount, :token)
  end

end