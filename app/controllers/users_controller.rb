class UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_user,          only: [:edit, :update, :donations, :creditcard, :update_creditcard]
  before_action :set_customer,      only: [:creditcard, :update_creditcard]
  before_action :set_card,          only: [:creditcard]
  
  layout 'user', except: [:index]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_slug(params[:id])
  end

  def edit; end

  def update
  	respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to @user, notice: 'Your details have been updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def donations; end

  def creditcard; end

  def update_creditcard
  	@customer.card = params[:token]
  	respond_to do |format|
      if @customer.save
        format.html { redirect_to @user, notice: 'Your credit card has been updated.' }
      else
        format.html { render action: 'creditcard' }
      end
    end
  end

private

  def set_user
    @user = current_user || not_found
  end

  def set_customer
    @customer = Stripe::Customer.retrieve(current_user.stripe_id) || not_found
  end

  def set_card
    @card = @customer.cards.retrieve(@customer.default_card) || not_found
  end

  def user_params
    params.require(:user).permit(:name, :first_name, :last_name, :photo, :email, org_attributes: [:id, :name])
  end

end
